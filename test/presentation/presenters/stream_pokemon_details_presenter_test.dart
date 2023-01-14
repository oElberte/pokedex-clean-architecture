import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/presentation/presenters/presenters.dart';

import 'mocks/handle_favorite.mocks.dart';

void main() {
  late MockHandleFavorite handleFavorite;
  late StreamPokemonDetailsPresenter sut;
  late int index;

  setUp(() {
    handleFavorite = MockHandleFavorite();
    sut = StreamPokemonDetailsPresenter(handleFavorite);
    index = faker.randomGenerator.integer(10);
  });

  test('Should call addFavorite on favorite press', () async {
    sut.onFavoritePress(index);

    verify(handleFavorite.addFavorite(index)).called(1);
  });

  test('Should call getIcon with correct index and return the correct icon', () async {
    when(handleFavorite.getIcon(any)).thenReturn(const Icon(Icons.favorite_border));

    final icon = sut.getIcon(index);

    verify(handleFavorite.getIcon(index)).called(1);
    expect(icon.toString(), const Icon(Icons.favorite_border).toString());
  });
}
