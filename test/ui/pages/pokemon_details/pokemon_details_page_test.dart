import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/helpers/helpers.dart';
import 'package:pokedex/ui/pages/pages.dart';

import '../mocks/pokemon_details_presenter.mocks.dart';
import '../mocks/pokemon_list_presenter.mocks.dart';

void main() {
  late BuildContext buildContext;
  late List<PokemonViewModel> viewModelList;
  late MockPokemonListPresenter listPresenter;
  late MockPokemonDetailsPresenter detailsPresenter;
  late StreamController<List<PokemonViewModel>> pokemonController;
  late StreamController<bool> isLoadingController;

  void initStreams() {
    pokemonController = StreamController<List<PokemonViewModel>>.broadcast();
    isLoadingController = StreamController<bool>.broadcast();
  }

  void mockStreams() {
    when(listPresenter.pokemonStream).thenAnswer(
      (_) => pokemonController.stream,
    );
    when(listPresenter.isLoadingStream).thenAnswer(
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

  void mockIcon() => when(detailsPresenter.getIcon(any))
      .thenReturn(const Icon(Icons.favorite_border));

  Future<void> loadPageWithArguments(WidgetTester tester, {required int tappedIndex}) async {
    viewModelList = makePokemons();
    listPresenter = MockPokemonListPresenter();
    detailsPresenter = MockPokemonDetailsPresenter();
    initStreams();
    mockStreams();
    mockIcon();
    final pokemonDetailsPage = MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        var routes = {
          "/": (context) {
            buildContext = context;
            return const Scaffold();
          },
          "/fake_details": (context) {
            return PokemonDetailsPage(
              detailsPresenter: detailsPresenter,
              args: settings.arguments as PokemonDetailsArguments,
            );
          }
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(
          builder: (context) => builder(context),
        );
      },
    );
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(pokemonDetailsPage);
    });

    Navigator.pushNamed(
      buildContext,
      '/fake_details',
      arguments: PokemonDetailsArguments(
        listPresenter: listPresenter,
        viewModels: viewModelList,
        tappedIndex: tappedIndex,
      ),
    );

    await mockNetworkImagesFor(() async => await tester.pump());
  }

  tearDown(() => closeStreams());

  testWidgets('Should init with correct state', (tester) async {
    await loadPageWithArguments(tester, tappedIndex: 0);

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() => tester.pump());

    expect(find.text(viewModelList[0].name), findsOneWidget);
  });

  testWidgets('Should present error if LoadData fails', (tester) async {
    await loadPageWithArguments(tester, tappedIndex: 0);

    pokemonController.addError(UIError.unexpected.description);
    await mockNetworkImagesFor(() async => await tester.pump());

    expect(find.text(UIError.unexpected.description), findsOneWidget);
    expect(find.text('Refresh'), findsOneWidget);
    expect(find.text(viewModelList[0].name), findsNothing);
  });

  testWidgets('Should call LoadData on refresh button click', (tester) async {
    await loadPageWithArguments(tester, tappedIndex: 0);

    expectLater(listPresenter.pokemonStream, emitsError(UIError.unexpected.description));

    pokemonController.addError(UIError.unexpected.description);
    await mockNetworkImagesFor(() async => await tester.pump());

    expectLater(listPresenter.pokemonStream, emits(makePokemons()));
    await tester.tap(find.text('Refresh'));
    await mockNetworkImagesFor(() async => await tester.pump());

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump());

    verify(listPresenter.loadData()).called(1);
  });

  testWidgets('Should call LoadData last index on carousel', (tester) async {
    await loadPageWithArguments(tester, tappedIndex: 1);

    //* Since the tappedIndex on Arguments is the last index, it updates
    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump());

    verify(listPresenter.loadData()).called(1);
  });

  testWidgets('Should call onFavoritePress on favorite button pressed', (tester) async {
    await loadPageWithArguments(tester, tappedIndex: 0);

    pokemonController.add(makePokemons());
    await mockNetworkImagesFor(() async => await tester.pump());

    await tester.tap(find.byIcon(Icons.favorite_border));
    await mockNetworkImagesFor(() async => await tester.pump());

    verify(detailsPresenter.onFavoritePress(any)).called(1);
  });

  //* I don't have tests for Loading in this page, since the PokemonListPage handles showLoading.
}
