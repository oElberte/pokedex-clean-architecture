import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/helpers/helpers.dart';

import 'package:pokedex/ui/pages/pages.dart';

import '../mocks/pokemon_list_presenter.mocks.dart';

void main() {
  late MockPokemonListPresenter presenter;
  late StreamController<List<PokemonViewModel>> pokemonController;
  late StreamController<bool> isLoadingController;
  late StreamController<String?> navigateToController;

  void initStreams() {
    pokemonController = StreamController<List<PokemonViewModel>>.broadcast();
    isLoadingController = StreamController<bool>.broadcast();
    navigateToController = StreamController<String?>.broadcast();
  }

  void mockStreams() {
    when(presenter.pokemonStream).thenAnswer(
      (_) => pokemonController.stream,
    );
    when(presenter.isLoadingStream).thenAnswer(
      (_) => isLoadingController.stream.distinct(),
    );
    when(presenter.navigateToStream).thenAnswer(
      (_) => navigateToController.stream.distinct(),
    );
  }

  void closeStreams() {
    pokemonController.close();
    isLoadingController.close();
    navigateToController.close();
  }

  List<PokemonViewModel> makePokemons() => const [
        PokemonViewModel(
          id: '1',
          name: 'Bulbasaur',
          imageUrl: 'http://teste.com/',
          height: '6',
          weight: '70',
          stats: [
            StatViewModel(
              stat: 1,
              name: 'HP',
            ),
          ],
          types: [
            'Grass',
          ],
        ),
        PokemonViewModel(
          id: '2',
          name: 'Ivysaur',
          imageUrl: 'http://teste2.com/',
          height: '10',
          weight: '80',
          stats: [
            StatViewModel(
              stat: 1,
              name: 'HP',
            ),
            StatViewModel(
              stat: 2,
              name: 'ATK',
            ),
          ],
          types: [
            'Grass',
            'Poison',
          ],
        ),
      ];

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockPokemonListPresenter();
    initStreams();
    mockStreams();
    final pokemonListPage = MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return PokemonListPage(presenter);
        },
        '/any_route': (context) {
          return const Scaffold(
            body: Text('fake_page'),
          );
        },
      },
    );
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(pokemonListPage);
    });
  }

  tearDown(() => closeStreams());

  testWidgets('Should call loadData on page load', (tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctly', (tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error if LoadData fails', (tester) async {
    await loadPage(tester);

    pokemonController.addError(UIError.unexpected.description);
    await mockNetworkImagesFor(() async => await tester.pump());

    expect(find.text(UIError.unexpected.description), findsOneWidget);
    expect(find.text('Refresh'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsNothing);
  });

  testWidgets('Should present list if loadData succeeds', (tester) async {
    await loadPage(tester);

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump());

    expect(find.text(UIError.unexpected.description), findsNothing);
    expect(find.text('Refresh'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.text('Ivysaur'), findsOneWidget);
    expect(find.text('Poison'), findsOneWidget);
    expect(find.text('Grass'), findsNWidgets(2));
  });

  testWidgets('Should call LoadData on refresh button click', (tester) async {
    await loadPage(tester);

    expectLater(
        presenter.pokemonStream, emitsError(UIError.unexpected.description));

    pokemonController.addError(UIError.unexpected.description);
    await mockNetworkImagesFor(() async => await tester.pump());

    expectLater(presenter.pokemonStream, emits(makePokemons()));
    await tester.tap(find.text('Refresh'));
    await mockNetworkImagesFor(() async => await tester.pump());

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump());

    verify(presenter.loadData()).called(2);
  });

  testWidgets('Should call navigateTo on pokémon click', (tester) async {
    await loadPage(tester);

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump());

    await tester.tap(find.text('Bulbasaur'));
    await mockNetworkImagesFor(() async => await tester.pump());

    verify(presenter.goToDetails()).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(find.text('fake_page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump());

    navigateToController.add('');
    await mockNetworkImagesFor(() async => await tester.pump());
    expect(find.text('Bulbasaur'), findsOneWidget);

    navigateToController.add(null);
    await mockNetworkImagesFor(() async => await tester.pump());
    expect(find.text('Bulbasaur'), findsOneWidget);
  });
}
