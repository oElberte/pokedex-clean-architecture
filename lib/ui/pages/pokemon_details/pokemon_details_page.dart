import 'package:flutter/material.dart';

import '../../components/components.dart';
import './pokemon_details_presenter.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonDetailsPresenter presenter;

  const PokemonDetailsPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;

     return StreamBuilder<List<PokemonViewModel>>(
        stream: presenter.pokemonStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String name = snapshot.data![index].name;

            return Scaffold(
              appBar: AppBar(
                title: Text(name),
              ),
              body: Column(
                children: [
                  Image.network('image'),
                  Text(name),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      );
  }
}
