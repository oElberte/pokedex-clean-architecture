import 'package:flutter/material.dart';

import './pokemon_details_arguments.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PokemonDetailsArguments;
    final index = args.index;
    final viewModels = args.viewModels;

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModels[index].name),
      ),
      body: Column(
        children: [
          Image.network(viewModels[index].imageUrl),
          Text(viewModels[index].stats[0].name),
        ],
      ),
    );
  }
}
