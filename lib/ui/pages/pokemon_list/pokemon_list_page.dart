import 'package:flutter/material.dart';

import '../../components/components.dart';
import './pokemon_list_presenter.dart';

class PokemonListPage extends StatelessWidget {
  final PokemonListPresenter? presenter;

  const PokemonListPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    presenter!.loadData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: Builder(builder: (context) {
        presenter!.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 20,
          itemBuilder: (ctx, i) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bulbasaur',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Image.network(
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
                        cacheHeight: 120,
                        cacheWidth: 120,
                        height: 80,
                        width: 80,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Poison',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Grass',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '#000',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
