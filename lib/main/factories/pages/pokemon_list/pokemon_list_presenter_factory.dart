import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

PokemonListPresenter makePokemonListPresenter() {
  return StreamPokemonPresenter(
    makeLoadPokemon(),
  );
}
