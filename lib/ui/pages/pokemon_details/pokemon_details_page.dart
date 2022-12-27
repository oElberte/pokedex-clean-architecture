import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import './pokemon_details_presenter.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonDetailsPresenter presenter;

  const PokemonDetailsPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    var globalIndex = ModalRoute.of(context)!.settings.arguments as int;

    return Builder(
      builder: (context) {
        presenter.isLoadingStream.listen((isLoading) async {
          if (isLoading) {
            await showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        return StreamBuilder<List<PokemonViewModel>>(
          stream: presenter.pokemonStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<PokemonViewModel> viewModels = snapshot.data!;
              String name = viewModels[globalIndex].name;

              return Scaffold(
                appBar: AppBar(
                  title: Text(name),
                ),
                body: CarouselSlider.builder(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      globalIndex = index;
                    },
                  ),
                  itemCount: viewModels.length,
                  itemBuilder: (context, index, realIndex) {
                    if (viewModels.length == (realIndex + 1)) {
                      presenter.loadData();
                    }

                    return Column(
                      children: [
                        Image.network(viewModels[index].imageUrl),
                        Text(viewModels[index].height),
                      ],
                    );
                  },
                ),
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
    );
  }
}
