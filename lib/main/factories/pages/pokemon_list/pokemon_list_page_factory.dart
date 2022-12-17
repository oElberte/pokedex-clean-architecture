import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

Widget makePokemonListPage() {
  return PokemonListPage(
    makePokemonListPresenter(),
  );
}
