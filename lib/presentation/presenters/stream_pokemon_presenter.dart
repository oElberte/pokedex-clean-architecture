import 'dart:async';

import 'package:pokedex/presentation/helpers/helpers.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/components/components.dart';
import '../../ui/helpers/helpers.dart';
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
  Stream<List<PokemonViewModel>> get pokemonStream =>
      _controller.stream.map((state) => state.pokemon).distinct();
  @override
  Stream<String?> get pokemonErrorStream =>
      _controller.stream.map((state) => state.pokemonError).distinct();
  @override
  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  StreamPokemonPresenter(this.loadPokemon);

  void _update() => _controller.add(_state);

  @override
  Future<void> loadData() async {
    _state.isLoading = true;
    _update();
    try {
      final pokemonEntity = await loadPokemon.fetch();
      final pokemonList = pokemonEntity.map((p) => p.toViewModel()).toList();
      _state.pokemon.addAll(pokemonList);
      _update();
    } on DomainError {
      _state.pokemonError = UIError.unexpected.description;
    } finally {
      _state.isLoading = false;
      _update();
    }
  }

  void dispose() {
    _controller.close();
  }
}
