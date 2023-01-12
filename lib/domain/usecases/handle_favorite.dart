import 'package:flutter/material.dart';

abstract class HandleFavorite {
  void onFavoritePress(int index);
  Widget getIcon(int index);
}