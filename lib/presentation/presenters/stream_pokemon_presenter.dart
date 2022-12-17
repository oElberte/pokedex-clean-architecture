import 'dart:async';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/components/components.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../helpers/helpers.dart';

class StreamPokemonPresenter implements PokemonListPresenter {
  final LoadPokemon loadPokemon;

  final _controller = StreamController<List<PokemonViewModel>>.broadcast();

  @override
  Stream<List<PokemonViewModel>> get pokemonStream => _controller.stream.distinct();

  StreamPokemonPresenter(this.loadPokemon);

  @override
  Future<void> loadData() async {
    try {
      final pokemonEntity = await loadPokemon.fetch();
      final pokemonList = pokemonEntity.map((p) => p.toViewModel()).toList();
      _controller.add(pokemonList);
    } on DomainError catch (e) {
      switch (e) {
        case DomainError.invalidData:
          _controller.addError(UIError.invalidData.description);
          break;
        case DomainError.badRequest:
          _controller.addError(UIError.badRequest.description);
          break;
        default:
          _controller.addError(UIError.unexpected.description);
          break;
      }
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
