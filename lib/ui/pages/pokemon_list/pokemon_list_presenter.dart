abstract class PokemonListPresenter {
  Stream<bool> get isLoadingStream;

  Future<void> loadData();
}
