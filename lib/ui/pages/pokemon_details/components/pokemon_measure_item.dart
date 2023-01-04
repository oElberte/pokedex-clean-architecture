import 'package:flutter/material.dart';

import '../../../components/components.dart';

class PokemonMeasureItem extends StatelessWidget {
  const PokemonMeasureItem({
    Key? key,
    required this.pokemon,
    required this.measure,
  }) : super(key: key);

  final PokemonViewModel pokemon;
  final String measure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          pokemon.height,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(measure),
      ],
    );
  }
}
