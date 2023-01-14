import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../pages.dart';
import './pokemon_row_name_and_buttons.dart';

class PokemonCarousel extends StatelessWidget {
  const PokemonCarousel({
    Key? key,
    required this.screenHeight,
    required this.bgColor,
    required this.actualIndex,
    required this.onScreenPokemon,
    required this.pokemonList,
    required this.detailsPresenter,
    required this.onFavoritePress,
    required this.onPageChanged,
  }) : super(key: key);

  final double screenHeight;
  final Color bgColor;
  final int actualIndex;
  final PokemonViewModel onScreenPokemon;
  final List<PokemonViewModel> pokemonList;
  final PokemonDetailsPresenter detailsPresenter;
  final void Function() onFavoritePress;
  final void Function(int index) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: screenHeight / 2.3,
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
          height: screenHeight / 2.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RowNameAndButtons(
                name: onScreenPokemon.name,
                icon: detailsPresenter.getIcon(actualIndex),
                onFavoritePress: onFavoritePress,
              ),
              CarouselSlider.builder(
                options: CarouselOptions(
                  initialPage: actualIndex,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.6,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.7,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  onPageChanged: (index, reason) {
                    onPageChanged(index);
                  },
                ),
                itemCount: pokemonList.length,
                itemBuilder: (context, index, realIndex) {
                  return Image.network(
                    pokemonList[index].imageUrl,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
