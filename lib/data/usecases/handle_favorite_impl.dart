import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../domain/usecases/usecases.dart';

class HandleFavoriteImpl implements HandleFavorite {
  final HiveInterface hive;

  HandleFavoriteImpl(this.hive);

  static const favoritesBox = 'favorites';

  @override
  void addFavorite(int index) {
    final box = hive.box<int>(favoritesBox);

    if (box.containsKey(index)) {
      box.delete(index);
    } else {
      box.put(index, index);
    }
  }

  @override
  Widget getIcon(int index) {
    final box = hive.box<int>(favoritesBox);

    if (box.containsKey(index)) {
      return const Icon(Icons.favorite, color: Colors.white, size: 34);
    } else {
      return const Icon(Icons.favorite_border, color: Colors.white, size: 34);
    }
  }

  @override
  int getIndex(int index) {
    final box = hive.box<int>(favoritesBox);

    return box.getAt(index)!;
  }
}
