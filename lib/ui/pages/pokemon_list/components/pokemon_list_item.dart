import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import 'pokemon_list_type_item.dart';

class PokemonListItem extends StatelessWidget {
  final PokemonViewModel viewModel;

  const PokemonListItem({
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getPokemonColor(viewModel.types[0]),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            viewModel.name,
            style: const TextStyle(
              shadows: [
                Shadow(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Image.network(
            viewModel.imageUrl,
            cacheHeight: 150,
            cacheWidth: 150,
            height: 100,
            width: 100,
          ),
          Text(
            viewModel.id,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              fontSize: 18,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: viewModel.types
                .map((type) => PokemonListTypeItem(type))
                .toList(),
          ),
        ],
      ),
    );
  }
}
