import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../pages.dart';

class PokemonList extends StatelessWidget {
  final List<PokemonViewModel> viewModels;
  final PokemonFavoritesPresenter presenter;
  final void Function() onDetailsPop;

  const PokemonList({
    Key? key,
    required this.viewModels,
    required this.presenter,
    required this.onDetailsPop,
  }) : super(key: key);

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
      itemCount: viewModels.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            await Navigator.pushNamed(
              context,
              '/pokemon_details',
              arguments: PokemonDetailsArguments(
                viewModels: viewModels,
                tappedIndex: index,
              ),
            );
            onDetailsPop();
          },
          child: PokemonListItem(viewModel: viewModels[index]),
        );
      },
    );
  }
}
