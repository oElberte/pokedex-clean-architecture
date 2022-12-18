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
  late PokemonListPresenter presenter;
  late StreamController<List<PokemonViewModel>> pokemonController;

  void initStreams() {
    pokemonController = StreamController<List<PokemonViewModel>>.broadcast();
  }

  void mockStreams() {
    when(presenter.pokemonStream).thenAnswer(
      (_) => pokemonController.stream.distinct(),
    );
  }

  void closeStreams() {
    pokemonController.close();
  }

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
      await tester.pump(Duration.zero);
    });
  }

  List<PokemonViewModel> makePokemons() => const [
        PokemonViewModel(
          next: 'https://next.com',
          previous: null,
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

  tearDown(() => closeStreams());

  testWidgets('Should call LoadData on page load', (tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should start with loading', (tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Should present error if LoadData fails', (tester) async {
    await loadPage(tester);

    pokemonController.addError(UIError.unexpected.description);
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));

    expect(find.text(UIError.unexpected.description), findsOneWidget);
    expect(find.text('Refresh'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsNothing);
  });

  testWidgets('Should present list loadData succeeds', (tester) async {
    await loadPage(tester);

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));

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

    expectLater(presenter.pokemonStream, emitsError(UIError.unexpected.description));

    pokemonController.addError(UIError.unexpected.description);
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));

    expectLater(presenter.pokemonStream, emits(makePokemons()));
    await tester.tap(find.text('Refresh'), warnIfMissed: false);
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should close streams on dispose', (tester) async {
    await loadPage(tester);

    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));

    addTearDown(() {
      verify(presenter.dispose()).called(1);
    });
  });
}
