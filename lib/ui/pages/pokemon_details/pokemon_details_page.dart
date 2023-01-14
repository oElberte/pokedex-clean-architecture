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
  late PokemonListPresenter listPresenter;
  late PokemonDetailsPresenter detailsPresenter;
  late PokemonViewModel onScreenPokemon;

  @override
  void initState() {
    actualIndex = widget.args.tappedIndex;
    viewModels = widget.args.viewModels;
    listPresenter = widget.args.listPresenter;
    detailsPresenter = widget.detailsPresenter;
    onScreenPokemon = viewModels[actualIndex];
    bgColor = getTypeColor(onScreenPokemon.types[0]);

    if ((actualIndex + 1) == viewModels.length) {
      listPresenter.loadData();
    }
    super.initState();
  }

  /*  
  I don't need to listen to the isLoadingStream from the 
  listPresenter since is a showDialog, with the other page listening,
  it applies the loading dialog to this one too           
  */
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<List<PokemonViewModel>>(
            initialData: viewModels,
            stream: listPresenter.pokemonStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorPage(
                  error: '${snapshot.error}',
                  onTap: listPresenter.loadData,
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
                      actualIndex: actualIndex,
                      onScreenPokemon: onScreenPokemon,
                      pokemonList: snapshot.data!,
                      detailsPresenter: detailsPresenter,
                      onFavoritePress: () {
                        setState(() {
                          detailsPresenter.onFavoritePress(actualIndex);
                        });
                      },
                      onPageChanged: (index) {
                        if (snapshot.data!.length == (index + 1)) {
                          listPresenter.loadData();
                        }
                        updatePokemon(snapshot.data![index], index);
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

  void updatePokemon(PokemonViewModel viewModel, int index) {
    setState(() {
      actualIndex = index;
      onScreenPokemon = viewModel;
      bgColor = getTypeColor(viewModel.types[0]);
    });
  }
}
