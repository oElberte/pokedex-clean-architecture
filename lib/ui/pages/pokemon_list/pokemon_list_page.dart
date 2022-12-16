import 'package:flutter/material.dart';
import '../pages.dart';

import '../../components/components.dart';
import 'pokemon_list_presenter.dart';
import 'components/components.dart';

class PokemonListPage extends StatelessWidget {
  //TODO: Remove optional binding
  final PokemonListPresenter? presenter;

  const PokemonListPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    presenter!.loadData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: StreamBuilder<List<PokemonViewModel>>(
        stream: presenter!.pokemonStream,
        builder: (context, snapshot) {
          presenter!.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          presenter!.pokemonErrorStream.listen((error) async {
            if (error != null && error.isNotEmpty) {
              showError(context, error, onTap: presenter!.loadData);
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
