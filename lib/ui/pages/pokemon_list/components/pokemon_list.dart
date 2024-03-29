import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../pokemon_list_presenter.dart';

class PokemonList extends StatelessWidget {
  final ScrollController controller;
  final List<PokemonViewModel> viewModels;
  final PokemonListPresenter presenter;
  final void Function(int) indexCallback;

  const PokemonList({
    Key? key,
    required this.controller,
    required this.viewModels,
    required this.presenter,
    required this.indexCallback,
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
      itemCount: viewModels.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            indexCallback(index);
            presenter.goToDetails();
          },
          child: PokemonListItem(viewModel: viewModels[index]),
        );
      },
    );
  }
}
