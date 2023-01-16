import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../pages.dart';
import './components/components.dart';

class PokemonFavoritesPage extends StatefulWidget {
  final PokemonFavoritesPresenter presenter;

  const PokemonFavoritesPage(this.presenter, {super.key});

  @override
  State<PokemonFavoritesPage> createState() => _PokemonFavoritesPageState();
}

class _PokemonFavoritesPageState extends State<PokemonFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: FutureBuilder<List<PokemonViewModel>>(
        future: widget.presenter.loadFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingIndicator();
          }

          if (snapshot.hasError) {
            return ErrorPage(
              error: '${snapshot.error}',
              onTap: () => setState(() {}),
            );
          }

          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Text(
                  "It looks like you don't have any Pokémon favorites yet...");
            } else {
              return PokemonList(
                viewModels: snapshot.data!,
                presenter: widget.presenter,
              );
            }
          }

          return const SizedBox();
        },
      ),
    );
  }
}
