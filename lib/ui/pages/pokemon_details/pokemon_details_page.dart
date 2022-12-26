import 'package:flutter/material.dart';

import '../../components/components.dart';
import './pokemon_details_presenter.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonDetailsPresenter presenter;

  const PokemonDetailsPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;

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
              String name = viewModels[index].name;

              return Scaffold(
                appBar: AppBar(
                  title: Text(name),
                ),
                body: Column(
                  children: [
                    Image.network(viewModels[index].imageUrl),
                    Text(name),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        );
      },
    );
  }
}
