import 'package:hive_flutter/hive_flutter.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

PokemonFavoritesPresenter makePokemonFavoritesPresenter() {
  return StreamPokemonFavoritesPresenter(
    loadPokemon: makeLoadPokemon(),
    favoritesBox: Hive.box<int>('favorites'),
  );
}
