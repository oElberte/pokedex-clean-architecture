import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/components/components.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../helpers/helpers.dart';

class StreamPokemonFavoritesPresenter implements PokemonFavoritesPresenter {
  final LoadPokemon loadPokemon;
  final Box<int> favoritesBox;

  StreamPokemonFavoritesPresenter({
    required this.loadPokemon,
    required this.favoritesBox,
  });

  final List<PokemonViewModel> _pokemonList = [];

  @override
  Future<List<PokemonViewModel>> loadFavorites() async {
    _pokemonList.clear();
    try {
      for (int id in favoritesBox.keys) {
        final pokemonEntity = await loadPokemon.fetch('${id + 1}');
        final pokemonViewModel = pokemonEntity.toViewModel();
        _pokemonList.add(pokemonViewModel);
      }
      return _pokemonList;
    } on DomainError catch (e) {
      switch (e) {
        case DomainError.invalidData:
          _pokemonList.clear();
          return Future.error(UIError.invalidData.description);
        case DomainError.badRequest:
          _pokemonList.clear();
          return Future.error(UIError.badRequest.description);
        default:
          _pokemonList.clear();
          return Future.error(UIError.unexpected.description);
      }
    }
  }
}
