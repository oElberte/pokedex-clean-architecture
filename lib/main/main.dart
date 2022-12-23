import 'package:flutter/material.dart';

import '../ui/pages/pages.dart';
import 'factories/factories.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return makePokemonListPage();
        },
        '/pokemon_details': (context) {
          return const PokemonDetailsPage();
        },
      },
    );
  }
}
