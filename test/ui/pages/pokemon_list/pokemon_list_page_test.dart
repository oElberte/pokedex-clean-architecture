import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex_clean_architecture/ui/components/components.dart';
import 'package:pokedex_clean_architecture/ui/helpers/helpers.dart';

import 'package:pokedex_clean_architecture/ui/pages/pages.dart';

import 'pokemon_list_page_test.mocks.dart';

@GenerateMocks([PokemonListPresenter])
void main() {
  late PokemonListPresenter presenter;
  late StreamController<bool> isLoadingController;
  late StreamController<PokemonListViewModel> pokemonListController;
  late StreamController<List<PokemonResultsViewModel>> pokemonResultsController;
  late StreamController<List<PokemonDetailsViewModel>> pokemonDetailsController;

  void initStreams() {
    isLoadingController = StreamController<bool>();
    pokemonListController = StreamController<PokemonListViewModel>();
    pokemonResultsController =
        StreamController<List<PokemonResultsViewModel>>();
    pokemonDetailsController =
        StreamController<List<PokemonDetailsViewModel>>();
  }

  void mockStreams() {
    when(presenter.isLoadingStream).thenAnswer(
      (_) => isLoadingController.stream,
    );
    when(presenter.pokemonListStream).thenAnswer(
      (_) => pokemonListController.stream,
    );
    when(presenter.pokemonDetailsStream).thenAnswer(
      (_) => pokemonDetailsController.stream,
    );
    when(presenter.pokemonResultsStream).thenAnswer(
      (_) => pokemonResultsController.stream,
    );
  }

  void closeStreams() {
    isLoadingController.close();
    pokemonListController.close();
    pokemonDetailsController.close();
    pokemonResultsController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockPokemonListPresenter();
    initStreams();
    mockStreams();
    final pokemonListPage = GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => PokemonListPage(presenter),
        ),
      ],
    );
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(pokemonListPage);
    });
  }

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

    pokemonDetailsController.addError(UIError.unexpected.description);
    await tester.pump();

    expect(
      find.text(
          'Something wrong happened. Try again later or refresh the app.'),
      findsOneWidget,
    );
    expect(find.text('Refresh'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsNothing);
  });
}
