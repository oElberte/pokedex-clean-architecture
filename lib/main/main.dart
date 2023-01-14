import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './factories/factories.dart';

const favoritesBox = 'favorites';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<int>(favoritesBox);
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
