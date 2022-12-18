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
  void initState() {
    super.initState();
    widget.presenter.loadData();
  }

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: StreamBuilder<List<PokemonViewModel>>(
        stream: widget.presenter.pokemonStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            showLoading(context);
            if (snapshot.hasData) {
              return PokemonListItems(snapshot.data!);
            }
          }

          if (snapshot.hasError) {
            return showError(
              snapshot.error.toString(),
              onTap: widget.presenter.loadData,
            );
          }

          if (snapshot.hasData) {
            hideLoading(context);
            return PokemonListItems(snapshot.data!);
          }

          return const SizedBox();
        },
      ),
    );
  }
}
