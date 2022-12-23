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

  final _pokemonController = StreamController<List<PokemonViewModel>>.broadcast();
  final _isLoadingController = StreamController<bool>.broadcast();
  final _navigateToController = StreamController<String?>.broadcast();

  @override
  Stream<List<PokemonViewModel>> get pokemonStream => _pokemonController.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoadingController.stream.distinct();

  @override
  Stream<String?> get navigateToStream => _navigateToController.stream.distinct();

  List<PokemonViewModel> pokemonList = [];

  @override
  Future<void> loadData() async {
    try {
      _isLoadingController.add(true);
      var length = pokemonList.length;
      for (int id = length + 1; id < length + 51; id++) {
        final pokemonEntity = await loadPokemon.fetch(id.toString());
        final pokemonViewModel = pokemonEntity.toViewModel();
        pokemonList.add(pokemonViewModel);
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
  void navigateTo(String page) {
    _navigateToController.add('/$page');
  }

  @override
  void dispose() {
    _pokemonController.close();
    _isLoadingController.close();
  }
}
