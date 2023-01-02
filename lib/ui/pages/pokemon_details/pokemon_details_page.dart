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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              onScreenPokemon.height,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const Text('Height'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              onScreenPokemon.weight,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const Text('Weight'),
                          ],
                        ),
                      ],
                    ),
                    const Text('Base stats'),
                    Column(
                        children: onScreenPokemon.stats
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(e.name),
                                      SizedBox(
                                        width: 250,
                                        child: TweenAnimationBuilder<double>(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          curve: Curves.easeInOut,
                                          tween: Tween<double>(
                                            begin: 0,
                                            end: e.stat / 255,
                                          ),
                                          builder: (context, value, _) => Stack(
                                            children: [
                                              LinearProgressIndicator(
                                                backgroundColor: Colors.grey,
                                                color: getStatColor(e.name),
                                                minHeight: 20,
                                                value: value,
                                              ),
                                              Align(
                                                alignment: Alignment.lerp(
                                                  Alignment.centerLeft,
                                                  Alignment.centerRight,
                                                  e.stat <= 15
                                                      ? value - 0.04
                                                      : value - 0.08,
                                                )!,
                                                child: Text(
                                                  e.stat.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: onScreenPokemon.types
                          .map(
                            (type) => Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: getTypeColor(type),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                type,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: height / 2.5,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60),
                              topLeft: Radius.circular(60),
                            ),
                            color: bgColor,
                          ),
                        ),
                        SizedBox(
                          height: height / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
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
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.zoom,
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
