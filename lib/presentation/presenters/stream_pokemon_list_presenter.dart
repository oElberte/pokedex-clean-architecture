import 'dart:async';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/components/components.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../helpers/helpers.dart';

class StreamPokemonListPresenter implements PokemonListPresenter {
  final LoadPokemon loadPokemon;

  StreamPokemonListPresenter(this.loadPokemon);

  final _pokemonController =
      StreamController<List<PokemonViewModel>>.broadcast();
  final _isLoadingController = StreamController<bool>.broadcast();

  @override
  Stream<List<PokemonViewModel>> get pokemonStream => _pokemonController.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoadingController.stream.distinct();

  List<PokemonViewModel> pokemonList = [];
  bool isLoading = false;

  @override
  Future<void> loadData() async {
    try {
      _isLoadingController.add(true);
      var length = pokemonList.length;
      for (int id = length + 1; id < length + 51; id++) {
        final pokemonEntity = await loadPokemon.fetch(id.toString());
        final pokemon = pokemonEntity.toViewModel();
        pokemonList.add(pokemon);
      }
      _pokemonController.add(pokemonList);
    } on DomainError catch (e) {
      switch (e) {
        case DomainError.invalidData:
          _pokemonController.addError(UIError.invalidData.description);
          pokemonList.clear();
          break;
        case DomainError.badRequest:
          _pokemonController.addError(UIError.badRequest.description);
          pokemonList.clear();
          break;
        default:
          _pokemonController.addError(UIError.unexpected.description);
          pokemonList.clear();
          break;
      }
    } finally {
      _isLoadingController.add(false);
    }
  }

  @override
  void dispose() {
    _pokemonController.close();
    _isLoadingController.close();
  }
}
