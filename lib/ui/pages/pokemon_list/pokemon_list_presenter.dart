import '../../components/pokemon_viewmodel.dart';

abstract class PokemonListPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<PokemonViewModel>> get pokemonStream;

  Future<void> loadData();
}