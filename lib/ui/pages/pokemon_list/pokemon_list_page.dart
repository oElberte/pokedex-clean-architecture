import 'package:flutter/material.dart';
import '../pages.dart';

import '../../components/components.dart';
import 'pokemon_list_presenter.dart';
import 'components/components.dart';

class PokemonListPage extends StatefulWidget {
  //TODO: Remove optional binding
  final PokemonListPresenter? presenter;

  const PokemonListPage(this.presenter, {super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.presenter!.loadData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: StreamBuilder<List<PokemonViewModel>>(
        stream: widget.presenter!.pokemonStream,
        builder: (context, snapshot) {
          widget.presenter!.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter!.pokemonErrorStream.listen((error) async {
            if (error != null && error.isNotEmpty) {
              showError(context, error, onTap: widget.presenter!.loadData);
            }
          });

          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PokemonListGridItem(snapshot.data![index]);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
