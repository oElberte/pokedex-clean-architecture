import '../../components/pokemon_viewmodel.dart';

abstract class PokemonListPresenter {
  Stream<List<PokemonViewModel>> get pokemonStream;
  Stream<bool> get isLoadingStream;

  Future<void> loadData();
  void dispose();
}
