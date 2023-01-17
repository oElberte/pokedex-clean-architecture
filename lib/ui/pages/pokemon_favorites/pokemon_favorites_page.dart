import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
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
        title: Text(R.string.favoriteTitle),
      ),
      body: FutureBuilder<List<PokemonViewModel>>(
        future: widget.presenter.loadFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: LoadingIndicator(),
            );
          }

          if (snapshot.hasError) {
            return ErrorPage(
              error: '${snapshot.error}',
              onTap: () => setState(() {}),
            );
          }

          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(R.string.favoriteListEmpty),
              );
            } else {
              return PokemonList(
                viewModels: snapshot.data!,
                presenter: widget.presenter,
                onDetailsPop: () => setState(() {}),
              );
            }
          }

          return const SizedBox();
        },
      ),
    );
  }
}
