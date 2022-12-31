import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../pages.dart';

class PokemonDetailsPage extends StatefulWidget {
  final PokemonDetailsArguments args;

  const PokemonDetailsPage(this.args, {super.key});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  /*  
  I don't need to listen to the isLoadingStream from the 
  listPresenter since is a showDialog, with the other page listening,
  it applies the loading dialog to this one too           
  */
  
  late Color bgColor;
  late int tappedIndex;
  late List<PokemonViewModel> viewModels;
  late PokemonListPresenter listPresenter;
  late PokemonViewModel onScreenPokemon;

  @override
  void initState() {
    tappedIndex = widget.args.tappedIndex;
    viewModels = widget.args.viewModels;
    listPresenter = widget.args.listPresenter;
    onScreenPokemon = viewModels[tappedIndex];
    bgColor = getPokemonColor(onScreenPokemon.types[0]);

    if ((tappedIndex + 1) == viewModels.length) {
      listPresenter.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(onScreenPokemon.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(onScreenPokemon.name),
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
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 400,
                      color: bgColor,
                    ),
                    CarouselSlider.builder(
                      key: const ValueKey('Carousel'),
                      options: CarouselOptions(
                        initialPage: tappedIndex,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.6,
                        height: 400,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.7,
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        onPageChanged: (index, _) {
                          if (snapshot.data!.length == (index + 1)) {
                            listPresenter.loadData();
                          }
                          updatePokemon(snapshot.data![index]);
                        },
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index, realIndex) {
                        return Image.network(
                          snapshot.data![index].imageUrl,
                          height: 350,
                        );
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

  void updatePokemon(PokemonViewModel viewModel) {
    setState(() {
      onScreenPokemon = viewModel;
      bgColor = getPokemonColor(viewModel.types[0]);
    });
  }
}
