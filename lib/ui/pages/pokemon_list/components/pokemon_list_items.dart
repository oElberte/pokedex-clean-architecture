import 'package:flutter/material.dart';

import '../../../components/components.dart';
import './pokemon_list_grid_item.dart';

class PokemonListItems extends StatelessWidget {
  final List<PokemonViewModel> data;

  const PokemonListItems(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) => PokemonListGridItem(data[index]),
    );
  }
}