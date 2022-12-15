import '../../components/pokemon_viewmodel.dart';

abstract class PokemonListPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<PokemonViewModel>?> get pokemonStream;
  Stream<String?> get pokemonErrorStream;

  Future<void> loadData();
}
