import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:pokedex_clean_architecture/data/usecases/usecases.dart';

import 'package:pokedex_clean_architecture/domain/entities/entities.dart';
import 'package:pokedex_clean_architecture/domain/helpers/helpers.dart';

import 'load_pokemon_impl_test.mocks.dart';

void main() {
  late MockLoadPokemonList loadList;
  late MockLoadPokemonDetails loadDetails;
  late LoadPokemonImpl sut;
  late PokemonListEntity pokemonListData;
  late List<PokemonDetailsEntity> pokemonDetailsData;

  PokemonListEntity mockListValidData() => PokemonListEntity(
        next: faker.internet.httpUrl(),
        previous: null,
        results: [
          PokemonResultEntity(
            name: faker.animal.name(),
            url: faker.internet.httpUrl(),
          ),
        ],
      );

  List<PokemonDetailsEntity> mockDetailsValidData() => [
        PokemonDetailsEntity(
          id: faker.randomGenerator.integer(1000),
          name: faker.animal.name(),
          imageUrl: faker.internet.httpUrl(),
          height: faker.randomGenerator.integer(100),
          weight: faker.randomGenerator.integer(100),
          stats: [
            StatEntity(
              stat: faker.randomGenerator.integer(100),
              name: faker.randomGenerator.string(10),
            ),
            StatEntity(
              stat: faker.randomGenerator.integer(100),
              name: faker.randomGenerator.string(10),
            ),
          ],
          types: [
            TypeEntity(
              type: faker.randomGenerator.string(10),
            ),
            TypeEntity(
              type: faker.randomGenerator.string(10),
            ),
          ],
        ),
        PokemonDetailsEntity(
          id: faker.randomGenerator.integer(1000),
          name: faker.animal.name(),
          imageUrl: faker.internet.httpUrl(),
          height: faker.randomGenerator.integer(100),
          weight: faker.randomGenerator.integer(100),
          stats: [
            StatEntity(
              stat: faker.randomGenerator.integer(100),
              name: faker.randomGenerator.string(10),
            ),
            StatEntity(
              stat: faker.randomGenerator.integer(100),
              name: faker.randomGenerator.string(10),
            ),
          ],
          types: [
            TypeEntity(
              type: faker.randomGenerator.string(10),
            ),
            TypeEntity(
              type: faker.randomGenerator.string(10),
            ),
          ],
        ),
      ];

  PostExpectation mockLoadListRequest() => when(loadList.fetch());

  PostExpectation mockLoadDetailsRequest() => when(loadDetails.fetch(any));

  void mockListError(DomainError error) =>
      mockLoadListRequest().thenThrow(error);

  void mockDetailsError(DomainError error) =>
      mockLoadDetailsRequest().thenThrow(error);

  void mockListData(PokemonListEntity data) {
    pokemonListData = data;
    mockLoadListRequest().thenAnswer((_) async => data);
  }

  void mockDetailsData(List<PokemonDetailsEntity> data) {
    pokemonDetailsData = data;
    mockLoadDetailsRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    loadList = MockLoadPokemonList();
    loadDetails = MockLoadPokemonDetails();
    sut = LoadPokemonImpl(
      loadList: loadList,
      loadDetails: loadDetails,
    );
    mockListData(mockListValidData());
    mockDetailsData(mockDetailsValidData());
  });

  test('Shoud call LoadList and LoadDetails on fetch', () async {
    await sut.fetch();

    verify(loadList.fetch()).called(1);
    verify(loadDetails.fetch(any)).called(1);
  });

  test('Should rethrow if LoadList or LoadDetails throw BadRequest', () async {
    mockListError(DomainError.badRequest);
    final future = sut.fetch();
    expect(future, throwsA(DomainError.badRequest));


    mockDetailsError(DomainError.badRequest);
    final future2 = sut.fetch();
    expect(future2, throwsA(DomainError.badRequest));
  });

  test('Should rethrow if LoadList or LoadDetails throw InvalidData', () async {
    mockListError(DomainError.invalidData);
    final future = sut.fetch();
    expect(future, throwsA(DomainError.invalidData));


    mockDetailsError(DomainError.invalidData);
    final future2 = sut.fetch();
    expect(future2, throwsA(DomainError.invalidData));
  });

  test('Should rethrow if LoadList or LoadDetails throw Unexpected', () async {
    mockListError(DomainError.unexpected);
    final future = sut.fetch();
    expect(future, throwsA(DomainError.unexpected));


    mockDetailsError(DomainError.unexpected);
    final future2 = sut.fetch();
    expect(future2, throwsA(DomainError.unexpected));
  });

  test('Should rethrow if LoadList or LoadDetails throw InvalidData', () async {
    mockListError(DomainError.invalidData);
    final future = sut.fetch();
    expect(future, throwsA(DomainError.invalidData));

    mockDetailsError(DomainError.invalidData);
    final future2 = sut.fetch();
    expect(future2, throwsA(DomainError.invalidData));
  });

  test('Should return PokemonDetails on 200', () async {
    final result = await sut.fetch();

    expect(result, [
      PokemonEntity(
        next: pokemonListData.next,
        previous: pokemonListData.previous,
        id: pokemonDetailsData[0].id,
        name: pokemonDetailsData[0].name,
        imageUrl: pokemonDetailsData[0].imageUrl,
        height: pokemonDetailsData[0].height,
        weight: pokemonDetailsData[0].weight,
        stats: [
          StatEntity(
            stat: pokemonDetailsData[0].stats[0].stat,
            name: pokemonDetailsData[0].stats[0].name,
          ),
          StatEntity(
            stat: pokemonDetailsData[0].stats[1].stat,
            name: pokemonDetailsData[0].stats[1].name,
          ),
        ],
        types: [
          TypeEntity(
            type: pokemonDetailsData[0].types[0].type,
          ),
          TypeEntity(
            type: pokemonDetailsData[0].types[1].type,
          ),
        ],
      ),
      PokemonEntity(
        next: pokemonListData.next,
        previous: pokemonListData.previous,
        id: pokemonDetailsData[1].id,
        name: pokemonDetailsData[1].name,
        imageUrl: pokemonDetailsData[1].imageUrl,
        height: pokemonDetailsData[1].height,
        weight: pokemonDetailsData[1].weight,
        stats: [
          StatEntity(
            stat: pokemonDetailsData[1].stats[0].stat,
            name: pokemonDetailsData[1].stats[0].name,
          ),
          StatEntity(
            stat: pokemonDetailsData[1].stats[1].stat,
            name: pokemonDetailsData[1].stats[1].name,
          ),
        ],
        types: [
          TypeEntity(
            type: pokemonDetailsData[1].types[0].type,
          ),
          TypeEntity(
            type: pokemonDetailsData[1].types[1].type,
          ),
        ],
      ),
    ]);
  });
}
