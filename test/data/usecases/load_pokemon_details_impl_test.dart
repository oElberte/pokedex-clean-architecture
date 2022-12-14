import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:pokedex_clean_architecture/data/http/http.dart';
import 'package:pokedex_clean_architecture/data/usecases/usecases.dart';

import 'package:pokedex_clean_architecture/domain/entities/entities.dart';
import 'package:pokedex_clean_architecture/domain/helpers/helpers.dart';

import 'mocks/http_client.mocks.dart';

void main() {
  late List<String> urlList;
  late MockHttpClient httpClient;
  late LoadPokemonDetailsImpl sut;
  late Map pokemonData;

  Map mockDataWithoutId() => {
        "name": "bulbasaur",
        "sprites": {
          "other": {
            "official-artwork": {
              "front_default":
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
            },
          },
        },
      };

  Map mockDataWithoutImage() => {
        "id": 1,
        "name": "bulbasaur",
      };

  Map mockValidData() => {
        "id": 1,
        "name": "bulbasaur",
        "sprites": {
          "other": {
            "official-artwork": {
              "front_default":
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
            },
          },
        },
        "height": 7,
        "weight": 69,
        "stats": [
          {
            "base_stat": 45,
            "effort": 0,
            "stat": {
              "name": "hp",
              "url": "https://pokeapi.co/api/v2/stat/1/",
            }
          },
          {
            "base_stat": 49,
            "effort": 0,
            "stat": {
              "name": "attack",
              "url": "https://pokeapi.co/api/v2/stat/2/",
            }
          },
        ],
        "types": [
          {
            "slot": 1,
            "type": {
              "name": "grass",
              "url": "https://pokeapi.co/api/v2/type/12/",
            }
          },
          {
            "slot": 2,
            "type": {
              "name": "poison",
              "url": "https://pokeapi.co/api/v2/type/4/",
            }
          },
        ],
      };

  PostExpectation mockRequest() => when(httpClient.request(any));

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  void mockHttpData(Map data) {
    pokemonData = data;
    mockRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    urlList = [faker.internet.httpUrl()];
    httpClient = MockHttpClient();
    sut = LoadPokemonDetailsImpl(httpClient: httpClient);
    mockHttpData(mockValidData());
  });

  test('Shoud call HttpClient on fetch', () async {
    await sut.fetch(urlList);

    verify(httpClient.request(any)).called(1);
  });

  test('Should throw BadRequestError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.fetch(urlList);

    expect(future, throwsA(DomainError.badRequest));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.fetch(urlList);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.fetch(urlList);

    expect(future, throwsA(DomainError.unexpected));
  });

  test(
      'Should throw InvalidDataError if HttpClient returns 200 with invalid data',
      () async {
    mockHttpData(mockDataWithoutId());
    final future = sut.fetch(urlList);
    expect(future, throwsA(DomainError.invalidData));

    mockHttpData(mockDataWithoutImage());
    final future2 = sut.fetch(urlList);
    expect(future2, throwsA(DomainError.invalidData));
  });

  test('Should return PokemonDetails on 200', () async {
    final result = await sut.fetch(urlList);

    expect(result, [
      PokemonDetailsEntity(
        id: pokemonData['id'],
        name: pokemonData['name'],
        imageUrl: pokemonData['sprites']['other']['official-artwork']
            ['front_default'],
        height: pokemonData['height'],
        weight: pokemonData['weight'],
        stats: [
          StatEntity(
            stat: pokemonData['stats'][0]['base_stat'],
            name: pokemonData['stats'][0]['stat']['name'],
          ),
          StatEntity(
            stat: pokemonData['stats'][1]['base_stat'],
            name: pokemonData['stats'][1]['stat']['name'],
          ),
        ],
        types: [
          TypeEntity(
            type: pokemonData['types'][0]['type']['name'],
          ),
          TypeEntity(
            type: pokemonData['types'][1]['type']['name'],
          ),
        ],
      ),
    ]);
  });
}
