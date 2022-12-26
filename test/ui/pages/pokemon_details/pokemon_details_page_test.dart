import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/helpers/helpers.dart';
import 'package:pokedex/ui/pages/pages.dart';

import 'pokemon_details_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PokemonDetailsPresenter>()])
void main() {
  late BuildContext buildContext;
  late List<PokemonViewModel> viewModelList;
  late PokemonDetailsPresenter presenter;
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

  Future<void> loadPageWithArguments(WidgetTester tester) async {
    viewModelList = makePokemons();
    presenter = MockPokemonDetailsPresenter();
    initStreams();
    mockStreams();
    final pokemonDetailsPage = MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) {
          buildContext = context;
          return const Scaffold();
        },
        '/fake_details': (context) {
          return PokemonDetailsPage(presenter);
        },
      },
    );
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(pokemonDetailsPage);
    });

    Navigator.pushNamed(
      buildContext,
      '/fake_details',
      arguments: 0,
    );

    await mockNetworkImagesFor(() => tester.pumpAndSettle());
  }

  tearDown(() => closeStreams());

  testWidgets('Should init with correct state', (tester) async {
    await loadPageWithArguments(tester);

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() => tester.pumpAndSettle());

    expect(find.text(viewModelList[0].name), findsNWidgets(2));
  });

  testWidgets('Should handle loading correctly', (tester) async {
    await loadPageWithArguments(tester);

    isLoadingController.add(true);
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await mockNetworkImagesFor(() async => await tester.pump(Duration.zero));
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error if LoadData fails', (tester) async {
    await loadPageWithArguments(tester);

    pokemonController.addError(UIError.unexpected.description);
    await mockNetworkImagesFor(() async => await tester.pumpAndSettle());

    expect(find.text(UIError.unexpected.description), findsOneWidget);
    expect(find.text('Refresh'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsNothing);
  });
}
