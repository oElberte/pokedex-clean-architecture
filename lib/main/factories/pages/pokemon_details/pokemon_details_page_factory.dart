import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

Widget makePokemonDetailsPage(Object? args) {
  return PokemonDetailsPage(
    detailsPresenter: makePokemonDetailsPresenter(),
    args: args as PokemonDetailsArguments,
  );
}
