import 'dart:async';

import '../../domain/usecases/usecases.dart';

import '../../ui/components/components.dart';
import '../../ui/pages/pages.dart';

class PokemonState {
  List<PokemonViewModel>? pokemon;
  String? pokemonError;
  bool isLoading = false;
}

class StreamPokemonPresenter implements PokemonListPresenter {
  final LoadPokemon loadPokemon;

  final _controller = StreamController<PokemonState>.broadcast();
  final _state = PokemonState();

  @override
  Stream<List<PokemonViewModel>?> get pokemonStream => _controller.stream.map((state) => state.pokemon).distinct();
  @override
  Stream<String?> get pokemonErrorStream => _controller.stream.map((state) => state.pokemonError).distinct();
  @override
  Stream<bool> get isLoadingStream => _controller.stream.map((state) => state.isLoading).distinct();

  StreamPokemonPresenter(this.loadPokemon);

  void _update() => _controller.add(_state);

  @override
  Future<void> loadData() async {
    await loadPokemon.fetch();
  }

  void dispose() {
    _controller.close();
  }
}
