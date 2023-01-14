import 'package:flutter/material.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class StreamPokemonDetailsPresenter implements PokemonDetailsPresenter {
  final HandleFavorite handleFavorite;

  StreamPokemonDetailsPresenter(this.handleFavorite);

  @override
  void onFavoritePress(int index) {
    handleFavorite.addFavorite(index);
  }

  @override
  Widget getIcon(int index) {
    return handleFavorite.getIcon(index);
  }
}