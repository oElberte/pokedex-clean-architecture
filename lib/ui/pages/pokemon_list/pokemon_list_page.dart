import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../pages.dart';
import './components/components.dart';
import './pokemon_list_presenter.dart';

class PokemonListPage extends StatefulWidget {
  final PokemonListPresenter presenter;

  const PokemonListPage(this.presenter, {super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.presenter.loadData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: StreamBuilder<List<PokemonViewModel>>(
        stream: widget.presenter.pokemonStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return showLoading();
          }

          if (snapshot.hasError) {
            return showError(
              snapshot.error.toString(),
              onTap: widget.presenter.loadData,
            );
          }

          if (snapshot.hasData) {
            return PokemonListItems(snapshot.data!);
          }

          return const SizedBox();
        },
      ),
    );
  }
}
