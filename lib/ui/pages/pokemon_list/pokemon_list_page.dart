import 'package:flutter/material.dart';
import 'package:pokedex_clean_architecture/ui/pages/pages.dart';

import '../../components/components.dart';
import './pokemon_list_presenter.dart';
import './components/components.dart';

class PokemonListPage extends StatelessWidget {
  final PokemonListPresenter? presenter;

  const PokemonListPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    presenter!.loadData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: Builder(
        builder: (context) {
          presenter!.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          return StreamBuilder<List<PokemonDetailsViewModel>>(
            stream: presenter!.pokemonDetailsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text('${snapshot.error}'),
                    TextButton(
                      onPressed: presenter!.loadData,
                      child: const Text('Refresh'),
                    ),
                  ],
                );
              }

              if (snapshot.hasData) {
                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
          );
        },
      ),
    );
  }
}
