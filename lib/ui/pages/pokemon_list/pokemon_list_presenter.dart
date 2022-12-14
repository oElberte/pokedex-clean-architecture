import '../../components/pokemon_viewmodel.dart';
import './pokemon_list.dart';

abstract class PokemonListPresenter {
  Stream<bool> get isLoadingStream;
  Stream<PokemonListViewModel> get pokemonListStream;
  Stream<List<PokemonResultsViewModel>> get pokemonResultsStream;
  Stream<List<PokemonViewModel>> get pokemonDetailsStream;

  Future<void> loadData();
}
