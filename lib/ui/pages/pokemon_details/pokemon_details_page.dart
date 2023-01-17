import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../pages.dart';
import './components/components.dart';

class PokemonDetailsPage extends StatefulWidget {
  final PokemonDetailsPresenter detailsPresenter;
  final PokemonDetailsArguments args;

  const PokemonDetailsPage({
    required this.detailsPresenter,
    required this.args,
    super.key,
  });

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late Color bgColor;
  late int actualIndex;
  late List<PokemonViewModel> viewModels;
  late PokemonDetailsPresenter detailsPresenter;
  late PokemonViewModel onScreenPokemon;
  PokemonListPresenter? listPresenter;

  @override
  void initState() {
    actualIndex = widget.args.tappedIndex;
    viewModels = widget.args.viewModels;
    listPresenter = widget.args.listPresenter;
    detailsPresenter = widget.detailsPresenter;
    onScreenPokemon = viewModels[actualIndex];
    bgColor = getTypeColor(onScreenPokemon.types[0]);

    if ((actualIndex + 1) == viewModels.length) {
      listPresenter?.loadData();
    }
    super.initState();
  }

  /*  I don't need to listen to the isLoadingStream from the 
  listPresenter since is a showDialog, with the other page listening,
  it applies the loading dialog to this one too */
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<List<PokemonViewModel>>(
            initialData: viewModels,
            stream: listPresenter?.pokemonStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorPage(
                  error: '${snapshot.error}',
                  onTap: listPresenter?.loadData ?? () {},
                );
              }

              if (snapshot.hasData) {
                return Column(
                  children: [
                    PokemonMeasures(onScreenPokemon),
                    PokemonStats(onScreenPokemon),
                    PokemonTypes(onScreenPokemon),
                    PokemonCarousel(
                      screenHeight: height,
                      bgColor: bgColor,
                      initialPage: actualIndex,
                      favoriteIndex: getCorrectIndex(),
                      onScreenPokemon: onScreenPokemon,
                      pokemonList: snapshot.data!,
                      detailsPresenter: detailsPresenter,
                      onFavoritePress: updateFavorite,
                      onPageChanged: (index) {
                        if (snapshot.data!.length == (index + 1)) {
                          listPresenter?.loadData();
                        }
                        updatePokemon(snapshot.data!, index);
                      },
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  int getCorrectIndex() {
    if (listPresenter == null) {
      return detailsPresenter.getBoxIndex(actualIndex);
    } else {
      return actualIndex;
    }
  }

  void updateFavorite() {
    detailsPresenter.onFavoritePress(getCorrectIndex());
    /* The listPresenter is only received from the Pokémon List Page, 
    so it is possible to check if the user is coming from
    the Pokémon List Page or the Pokémon Favorites Page */
    if (listPresenter == null) {
      viewModels.removeAt(actualIndex);
      if (viewModels.isEmpty) {
        Navigator.of(context).pop();
        return;
      } else if (actualIndex == viewModels.length) {
        updatePokemon(viewModels, actualIndex - 1);
      } else {
        updatePokemon(viewModels, actualIndex);
      }
    }
    setState(() {});
  }

  void updatePokemon(List<PokemonViewModel> viewModel, int index) {
    setState(() {
      actualIndex = index;
      onScreenPokemon = viewModel[index];
      bgColor = getTypeColor(viewModel[index].types[0]);
    });
  }
}
