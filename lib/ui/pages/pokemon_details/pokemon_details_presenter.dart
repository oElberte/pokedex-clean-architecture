import 'package:flutter/material.dart';

abstract class PokemonDetailsPresenter {
  void onFavoritePress(int index);
  Widget getIcon(int index);
}
