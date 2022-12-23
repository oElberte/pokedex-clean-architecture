import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../pages.dart';
import './components/components.dart';

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
    late int argsIndex;
    late List<PokemonViewModel> argsViewModels;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) async {
            if (isLoading) {
              await showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.navigateToStream.listen((page) {
            if (page != null && page.isNotEmpty) {
              if (page == '/pokemon_details') {
                Navigator.pushNamed(
                  context,
                  page,
                  arguments: PokemonDetailsArguments(
                    index: argsIndex,
                    viewModels: argsViewModels,
                  ),
                );
              } else {
                Navigator.pushNamed(context, page);
              }
            }
          });

          widget.presenter.loadData();

          return StreamBuilder<List<PokemonViewModel>>(
            stream: widget.presenter.pokemonStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PokemonViewModel> viewModels = snapshot.data!;
                argsViewModels = viewModels;

                return PokemonList(
                  controller: controller,
                  viewModels: viewModels,
                  presenter: widget.presenter,
                  indexCallback: (index) => argsIndex = index,
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
        },
      ),
    );
  }
}
