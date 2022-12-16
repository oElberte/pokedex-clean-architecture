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
  late StreamController<bool> isLoadingController;
  late StreamController<List<PokemonViewModel>> pokemonController;
  late StreamController<String?> pokemonErrorController;

  void initStreams() {
    isLoadingController = StreamController<bool>.broadcast();
    pokemonController = StreamController<List<PokemonViewModel>>.broadcast();
    pokemonErrorController = StreamController<String?>.broadcast();
  }

  void mockStreams() {
    when(presenter.isLoadingStream).thenAnswer(
      (_) => isLoadingController.stream.distinct(),
    );
    when(presenter.pokemonStream).thenAnswer(
      (_) => pokemonController.stream.distinct(),
    );
    when(presenter.pokemonErrorStream).thenAnswer(
      (_) => pokemonErrorController.stream.distinct(),
    );
  }

  void closeStreams() {
    isLoadingController.close();
    pokemonController.close();
    pokemonErrorController.close();
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
            TypeViewModel(
              type: 'Grass',
            ),
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
            TypeViewModel(
              type: 'Grass',
            ),
            TypeViewModel(
              type: 'Poison',
            ),
          ],
        ),
      ];

  tearDown(() => closeStreams());

  testWidgets('Shoud call LoadData on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error if pokemonDetailsStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    pokemonErrorController.add(UIError.unexpected.description);
    await tester.pump();

    expect(find.text(UIError.unexpected.description), findsOneWidget);
    expect(find.text('Refresh'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsNothing);
  });

  testWidgets('Should present list if pokemonDetailsStream succeeds',
      (WidgetTester tester) async {
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

  testWidgets('Should call LoadPokemons on refresh button click',
      (WidgetTester tester) async {
    await loadPage(tester);
    
    expectLater(presenter.pokemonErrorStream, emitsInOrder([UIError.unexpected.description, null]));

    pokemonErrorController.add(UIError.unexpected.description);
    await mockNetworkImagesFor(() async => await tester.pump());
    await tester.tap(find.text('Refresh'));

    pokemonErrorController.add(null);
    pokemonController.add(makePokemons());

    verify(presenter.loadData()).called(2);
  });
}
