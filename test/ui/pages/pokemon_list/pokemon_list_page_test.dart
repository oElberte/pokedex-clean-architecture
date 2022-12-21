import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/helpers/helpers.dart';

import 'package:pokedex/ui/pages/pages.dart';

import 'pokemon_list_page_test.mocks.dart';

@GenerateMocks([PokemonListPresenter])
void main() {
  late MockPokemonListPresenter presenter;
  late StreamController<List<PokemonViewModel>> pokemonController;
  late StreamController<bool> isLoadingController;

  void initStreams() {
    pokemonController = StreamController<List<PokemonViewModel>>.broadcast();
    isLoadingController = StreamController<bool>.broadcast();
  }

  void mockStreams() {
    when(presenter.pokemonStream).thenAnswer(
      (_) => pokemonController.stream,
    );
    when(presenter.isLoadingStream).thenAnswer(
      (_) => isLoadingController.stream.distinct(),
    );
  }

  void closeStreams() {
    pokemonController.close();
    isLoadingController.close();
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

  testWidgets('Should present list loadData succeeds', (tester) async {
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

    verify(presenter.loadData()).called(3);
  });
}
