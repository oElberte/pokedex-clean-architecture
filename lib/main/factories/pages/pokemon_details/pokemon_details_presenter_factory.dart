import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

PokemonDetailsPresenter makePokemonDetailsPresenter() {
  return StreamPokemonDetailsPresenter(
    makeHandleFavorite(),
  );
}
