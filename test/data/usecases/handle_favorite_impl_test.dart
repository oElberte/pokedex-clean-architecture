import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/data/usecases/usecases.dart';

void main() {
  late int index;
  late Box box;
  late HandleFavoriteImpl sut;

  setUp(() async {
    await Hive.initFlutter();
    index = faker.randomGenerator.integer(10);
    box = await Hive.openBox<int>('favorites');
    sut = HandleFavoriteImpl(Hive);
  });

  tearDown(() => box.clear());

  test('Box is open', () {
    expect(box.isOpen, true);
  });

  test('Shoud put the index in the box', () {
    sut.addFavorite(index);

    expect(box.keys, [index]);
  });

  test('Shoud delete if the value already exists', () {
    box.put(index, index);

    sut.addFavorite(index);

    expect(box.keys, []);
  });

  test('Shoud return the non favorite icon', () {
    final icon = sut.getIcon(index);

    expect(
        icon.toString(),
        const Icon(
          Icons.favorite_border,
          color: Colors.white,
          size: 34,
        ).toString());
  });

  test('Shoud return the favorite icon', () {
    box.put(index, index);

    final icon = sut.getIcon(index);

    expect(
        icon.toString(),
        const Icon(
          Icons.favorite,
          color: Colors.white,
          size: 34,
        ).toString());
  });

  test('Shoud return the correct index', () {
    box.put(index, index);

    final boxIndex = sut.getIndex(0);

    expect(boxIndex, index);
  });
}
