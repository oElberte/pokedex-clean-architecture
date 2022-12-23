import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/pages/pages.dart';

void main() {
  late BuildContext buildContext;
  late List<PokemonViewModel> viewModelList;

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
          return const PokemonDetailsPage();
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
}
