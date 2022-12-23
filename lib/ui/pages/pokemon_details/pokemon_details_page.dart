import 'package:flutter/material.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('name'),
      ),
      body: Column(
        children: [
          Image.network('image'),
          Text('stat name'),
        ],
      ),
    );
  }
}