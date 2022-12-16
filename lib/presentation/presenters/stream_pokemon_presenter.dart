import 'dart:async';

import 'package:pokedex/presentation/helpers/helpers.dart';

import '../../domain/usecases/usecases.dart';

import '../../ui/components/components.dart';
import '../../ui/pages/pages.dart';

class PokemonState {
  List<PokemonViewModel> pokemon = [];
  String? pokemonError;
  bool isLoading = false;
}

class StreamPokemonPresenter implements PokemonListPresenter {
  final LoadPokemon loadPokemon;

  final _controller = StreamController<PokemonState>.broadcast();
  final _state = PokemonState();

  @override
  Stream<List<PokemonViewModel>> get pokemonStream => _controller.stream.map((state) => state.pokemon).distinct();
  @override
  Stream<String?> get pokemonErrorStream => _controller.stream.map((state) => state.pokemonError).distinct();
  @override
  Stream<bool> get isLoadingStream => _controller.stream.map((state) => state.isLoading).distinct();

  StreamPokemonPresenter(this.loadPokemon);

  void _update() => _controller.add(_state);

  @override
  Future<void> loadData() async {
    _state.isLoading = true;
    _update();
    final pokemonEntity = await loadPokemon.fetch();
    final pokemonList = pokemonEntity
        .map((pokemon) => PokemonViewModel(
              next: pokemon.next,
              previous: pokemon.previous,
              id: pokemon.id.toString(),
              name: pokemon.name.capitalize().removeGender(),
              imageUrl: pokemon.imageUrl,
              height: pokemon.height.toString(),
              weight: pokemon.weight.toString(),
              stats: pokemon.stats
                  .map((e) => StatViewModel(
                        stat: e.stat,
                        name: e.name.capitalize(),
                      ))
                  .toList(),
              types: pokemon.types
                  .map((e) => TypeViewModel(
                        type: e.type.capitalize(),
                      ))
                  .toList(),
            ))
        .toList();
    _state.pokemon.addAll(pokemonList);
    _update();
    _state.isLoading = false;
    _update();
  }

  void dispose() {
    _controller.close();
  }
}
