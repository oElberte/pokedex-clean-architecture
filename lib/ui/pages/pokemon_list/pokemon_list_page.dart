import 'package:flutter/material.dart';
import 'package:pokedex/ui/helpers/helpers.dart';

import '../../components/components.dart';
import '../pages.dart';
import './components/components.dart';

class PokemonListPage extends StatelessWidget {
  final PokemonListPresenter presenter;

  const PokemonListPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    late List<PokemonViewModel> viewModels;
    late int tappedIndex;

    //When the user gets to the end of the page, loads more Pokémon
    controller.addListener(() {
      final maxScroll = controller.position.maxScrollExtent;
      final actualPosition = controller.position.pixels;
      if (maxScroll == actualPosition) {
        presenter.loadData();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.appTitle),
        actions: [
          IconButton(
            onPressed: () => presenter.navigateTo('/pokemon_favorites'),
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) async {
            if (isLoading) {
              await showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          presenter.navigateToStream.listen((page) {
            if (page != null && page.isNotEmpty) {
              if (page == '/pokemon_details') {
                Navigator.pushNamed(
                  context,
                  page,
                  arguments: PokemonDetailsArguments(
                    viewModels: viewModels,
                    tappedIndex: tappedIndex,
                    listPresenter: presenter,
                  ),
                );
              } else {
                Navigator.pushNamed(context, page);
              }
            }
          });

          presenter.loadData();

          return StreamBuilder<List<PokemonViewModel>>(
            stream: presenter.pokemonStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                viewModels = snapshot.data!;

                return PokemonList(
                  controller: controller,
                  viewModels: viewModels,
                  presenter: presenter,
                  indexCallback: (index) => tappedIndex = index,
                );
              }

              if (snapshot.hasError) {
                return ErrorPage(
                  error: '${snapshot.error}',
                  onTap: presenter.loadData,
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
