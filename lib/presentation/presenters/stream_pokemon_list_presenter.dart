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

  final _controller = StreamController<List<PokemonViewModel>>.broadcast();

  @override
  Stream<List<PokemonViewModel>> get pokemonStream => _controller.stream.distinct();

  final List<PokemonViewModel> _list = [];

  String? _nextUrl;

  @override
  Future<void> loadData() async {
    try {
      final pokemonEntity = await loadPokemon.fetch(nextUrl: _nextUrl);
      final pokemonList = pokemonEntity.map((p) => p.toViewModel()).toList();
      _list.addAll(pokemonList);
      _controller.add(_list);
      _nextUrl = pokemonList.last.next;
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
    //_list = [];
    _controller.close();
  }
}
