import '../../components/pokemon_viewmodel.dart';

abstract class PokemonListPresenter {
  Stream<List<PokemonViewModel>> get pokemonStream;

  Future<void> loadData();
  void dispose();
}
