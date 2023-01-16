import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/pages/pages.dart';

import '../mocks/pokemon_favorites_presenter.mocks.dart';

void main() {
  late BuildContext buildContext;
  late List<PokemonViewModel> viewModelList;
  late MockPokemonFavoritesPresenter presenter;

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
    presenter = MockPokemonFavoritesPresenter();
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
          "/fake_favorites": (context) {
            return PokemonFavoritesPage(presenter);
          },
          "/pokemon_details": (context) {
            return const Scaffold(
              body: Text('fake_details'),
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
      '/fake_favorites',
      arguments: PokemonDetailsArguments(
        viewModels: viewModelList,
        tappedIndex: 0,
      ),
    );

    when(presenter.loadFavorites()).thenAnswer((_) async => viewModelList);
    await mockNetworkImagesFor(() async => await tester.pump());
  }

  testWidgets('Should call loadData on page load', (tester) async {
    await loadPageWithArguments(tester);

    verify(presenter.loadFavorites()).called(1);
  });

  testWidgets('Should present list if loadData succeeds', (tester) async {
    await loadPageWithArguments(tester);

    await mockNetworkImagesFor(() async => await tester.pumpAndSettle());

    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.text('Ivysaur'), findsOneWidget);
    expect(find.text('Poison'), findsOneWidget);
    expect(find.text('Grass'), findsNWidgets(2));
  });

  testWidgets('Should call navigateTo on pokémon click', (tester) async {
    await loadPageWithArguments(tester);

    await mockNetworkImagesFor(() async => await tester.pumpAndSettle());

    await tester.tap(find.text('Bulbasaur'));
    await mockNetworkImagesFor(() async => await tester.pumpAndSettle());

    expect(find.text('fake_details'), findsOneWidget);
  });
}
