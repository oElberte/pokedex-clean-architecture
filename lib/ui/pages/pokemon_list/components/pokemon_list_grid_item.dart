import 'package:flutter/material.dart';

import '../../../components/components.dart';

class PokemonListGridItem extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;

  const PokemonListGridItem(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Image.network(
                viewModel.imageUrl,
                cacheHeight: 120,
                cacheWidth: 120,
                height: 80,
                width: 80,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  viewModel.types[0].type,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                if (viewModel.types.length >= 2)
                Text(
                  viewModel.types[1].type,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  viewModel.id,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}