import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../pages.dart';
import './components/components.dart';
import './pokemon_list_presenter.dart';

class PokemonListPage extends StatefulWidget {
  final PokemonListPresenter presenter;

  const PokemonListPage(this.presenter, {super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    //When the user gets to the end of the page, loads more Pokémon
    controller.addListener(() {
      final maxScroll = controller.position.maxScrollExtent;
      final actualPosition = controller.position.pixels;
      if (maxScroll == actualPosition) {
        widget.presenter.loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) async {
          if (isLoading) {
            await showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget.presenter.loadData();

        return StreamBuilder<List<PokemonViewModel>>(
          stream: widget.presenter.pokemonStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<PokemonViewModel> data = snapshot.data!;
              return PokemonList(
                controller: controller,
                data: data,
              );
            }

            if (snapshot.hasError) {
              return ErrorPage(
                error: snapshot.error,
                onTap: () => setState(() {
                  widget.presenter.loadData();
                }),
              );
            }

            return const SizedBox();
          },
        );
      }),
    );
  }
}
