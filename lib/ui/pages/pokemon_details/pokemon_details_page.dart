import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../pages.dart';
import './components/components.dart';

class PokemonDetailsPage extends StatefulWidget {
  final PokemonDetailsArguments args;

  const PokemonDetailsPage(this.args, {super.key});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
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
    bgColor = getTypeColor(onScreenPokemon.types[0]);

    if ((tappedIndex + 1) == viewModels.length) {
      listPresenter.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*  
    I don't need to listen to the isLoadingStream from the 
    listPresenter since is a showDialog, with the other page listening,
    it applies the loading dialog to this one too           
    */
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

                    //Pokémon Carousel
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: height / 2.3,
                          decoration: BoxDecoration(
                            color: bgColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 6,
                                offset: Offset(0, -2),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60),
                              topLeft: Radius.circular(60),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 2.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  //TODO: Implement scroll back to index on pop and onTap directly on next or previous Pokémon
                                  IconButton(
                                    onPressed: Navigator.of(context).pop,
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 34,
                                    ),
                                  ),
                                  Text(
                                    onScreenPokemon.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 34,
                                    ),
                                  ),
                                ],
                              ),
                              CarouselSlider.builder(
                                options: CarouselOptions(
                                  initialPage: tappedIndex,
                                  enableInfiniteScroll: false,
                                  viewportFraction: 0.6,
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
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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
      bgColor = getTypeColor(viewModel.types[0]);
    });
  }
}
