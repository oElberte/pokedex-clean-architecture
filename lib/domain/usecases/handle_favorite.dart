import 'package:flutter/material.dart';

abstract class HandleFavorite {
  void addFavorite(int index);
  Widget getIcon(int index);
}