import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './factories/factories.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<int>('favorites');
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
      onGenerateRoute: (settings) {
        var routes = {
          "/": (context) {
            return makePokemonListPage();
          },
          "/pokemon_details": (context) {
            return makePokemonDetailsPage(settings.arguments);
          },
          "/pokemon_favorites": (context) {
            return makePokemonFavoritesPage();
          }
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(
          builder: (context) => builder(context),
        );
      },
    );
  }
}
