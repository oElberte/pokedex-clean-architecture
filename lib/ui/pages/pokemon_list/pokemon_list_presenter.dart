import '../../components/pokemon_viewmodel.dart';

abstract class PokemonListPresenter {
  Stream<List<PokemonViewModel>> get pokemonStream;
  Stream<bool> get isLoadingStream;
  Stream<String?> get navigateToStream;

  Future<void> loadData();
  void navigateTo(String page);
  void goToDetails();
  void dispose();
}
