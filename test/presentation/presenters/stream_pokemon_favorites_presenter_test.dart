import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/helpers/domain_error.dart';
import 'package:pokedex/presentation/helpers/helpers.dart';
import 'package:pokedex/presentation/presenters/presenters.dart';
import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/helpers/helpers.dart';

import 'mocks/load_pokemon.mocks.dart';

void main() {
  late MockLoadPokemon loadPokemon;
  late StreamPokemonFavoritesPresenter sut;
  late PokemonEntity pokemonEntity;
  late Box<int> box;

  PokemonEntity makePokemonEntity() => PokemonEntity(
        id: faker.randomGenerator.integer(10),
        name: faker.animal.name(),
        imageUrl: faker.internet.httpUrl(),
        height: faker.randomGenerator.integer(100),
        weight: faker.randomGenerator.integer(100),
        stats: [
          StatEntity(
            stat: faker.randomGenerator.integer(10),
            name: faker.randomGenerator.string(10),
          ),
          StatEntity(
            stat: faker.randomGenerator.integer(10),
            name: faker.randomGenerator.string(10),
          ),
        ],
        types: [
          faker.randomGenerator.string(10),
          faker.randomGenerator.string(10),
        ],
      );

  PokemonViewModel makePokemonViewModel() => PokemonViewModel(
        id: pokemonEntity.id.toString().fixId(),
        name: pokemonEntity.name.toUpperCase().removeAdditional(),
        imageUrl: pokemonEntity.imageUrl,
        height: '${pokemonEntity.height / 10} M',
        weight: '${pokemonEntity.weight / 10} KG',
        stats: [
          StatViewModel(
            stat: pokemonEntity.stats[0].stat,
            name: pokemonEntity.stats[0].name.fixStats(),
          ),
          StatViewModel(
            stat: pokemonEntity.stats[1].stat,
            name: pokemonEntity.stats[1].name.fixStats(),
          ),
        ],
        types: [
          pokemonEntity.types[0].toUpperCase(),
          pokemonEntity.types[1].toUpperCase(),
        ],
      );

  PostExpectation mockLoadDataCall() => when(loadPokemon.fetch(any));

  void mockLoadData(PokemonEntity data) {
    pokemonEntity = data;
    mockLoadDataCall().thenAnswer((_) async => pokemonEntity);
  }

  void mockLoadDataError(DomainError error) {
    mockLoadDataCall().thenThrow(error);
  }

  setUp(() async {
    await Hive.initFlutter();
    box = await Hive.openBox<int>('favorites');
    await box.put(2, 2);
    loadPokemon = MockLoadPokemon();
    sut = StreamPokemonFavoritesPresenter(
      loadPokemon: loadPokemon,
      favoritesBox: box,
    );
    mockLoadData(makePokemonEntity());
  });

  tearDown(() => box.clear());

  test('Should call fetch on loadFavorites', () async {
    await sut.loadFavorites();

    verify(loadPokemon.fetch(any)).called(1);
  });

  test('Should emit correct events on success', () async {
    final favorites = await sut.loadFavorites();

    expect(favorites, [makePokemonViewModel()]);
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockLoadDataError(DomainError.unexpected);

    final future = sut.loadFavorites();

    expect(future, throwsA(UIError.unexpected.description));
  });

  test('Should emit correct events on InvalidData', () async {
    mockLoadDataError(DomainError.invalidData);

    final future = sut.loadFavorites();

    expect(future, throwsA(UIError.invalidData.description));
  });

  test('Should emit correct events on BadRequest', () async {
    mockLoadDataError(DomainError.badRequest);

    final future = sut.loadFavorites();

    expect(future, throwsA(UIError.badRequest.description));
  });
}
