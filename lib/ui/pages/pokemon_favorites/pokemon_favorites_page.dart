import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../pages.dart';
import './components/components.dart';

class PokemonFavoritesPage extends StatelessWidget {
  final PokemonFavoritesPresenter presenter;

  const PokemonFavoritesPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: FutureBuilder<List<PokemonViewModel>>(
        future: presenter.loadFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PokemonList(
              viewModels: snapshot.data!,
              presenter: presenter,
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          return const SizedBox();
        },
      ),
    );
  }
}
