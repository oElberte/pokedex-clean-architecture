import 'package:flutter/material.dart';

import '../../../components/components.dart';
import './pokemon_measure_item.dart';

class PokemonMeasures extends StatelessWidget {
  const PokemonMeasures(this.onScreenPokemon, {Key? key}) : super(key: key);

  final PokemonViewModel onScreenPokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PokemonMeasureItem(
            pokemon: onScreenPokemon,
            measure: 'Height',
          ),
          PokemonMeasureItem(
            pokemon: onScreenPokemon,
            measure: 'Weight',
          ),
        ],
      ),
    );
  }
}