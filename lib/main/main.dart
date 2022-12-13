import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './factories/factories.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: makePokemonListPage,
        ),
      ],
    );
  }
}
