import 'package:flutter/material.dart';

import '../../../components/components.dart';
import 'pokemon_list_item.dart';

class PokemonList extends StatelessWidget {
  final ScrollController controller;
  final List<PokemonViewModel> data;

  const PokemonList({
    Key? key,
    required this.controller,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
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
      itemBuilder: (context, index) {
        return PokemonListItem(data[index]);
      },
    );
  }
}
