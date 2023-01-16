import '../../components/pokemon_viewmodel.dart';

abstract class PokemonFavoritesPresenter {
  Future<List<PokemonViewModel>> loadFavorites();
}
