import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:pokedex_clean_architecture/data/http/http.dart';
import 'package:pokedex_clean_architecture/data/usecases/usecases.dart';

import 'package:pokedex_clean_architecture/domain/entities/entities.dart';
import 'package:pokedex_clean_architecture/domain/helpers/helpers.dart';

import 'mocks/http_client.mocks.dart';

void main() {
  late String url;
  late MockHttpClient httpClient;
  late LoadPokemonListImpl sut;
  late Map pokemonData;

  Map mockDataWithoutResults() => {
        'count': faker.randomGenerator.integer(1000),
        'next': faker.internet.httpUrl(),
        'previous': null,
      };

  Map mockDataWithoutNextAndPrevious() => {
        'count': faker.randomGenerator.integer(1000),
        'results': [
          {
            'name': faker.animal.name(),
            'url': faker.internet.httpUrl(),
          },
          {
            'name': faker.animal.name(),
            'url': faker.internet.httpUrl(),
          },
        ],
      };

  Map mockValidData() => {
        'count': faker.randomGenerator.integer(1000),
        'next': faker.internet.httpUrl(),
        'previous': null,
        'results': [
          {
            'name': faker.animal.name(),
            'url': faker.internet.httpUrl(),
          },
          {
            'name': faker.animal.name(),
            'url': faker.internet.httpUrl(),
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
    url = faker.internet.httpUrl();
    httpClient = MockHttpClient();
    sut = LoadPokemonListImpl(
      url: url,
      httpClient: httpClient,
    );
    mockHttpData(mockValidData());
  });

  test('Shoud call HttpClient on fetch', () async {
    await sut.fetch();

    verify(httpClient.request(url)).called(1);
  });

  test('Should throw BadRequestError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.fetch();

    expect(future, throwsA(DomainError.badRequest));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.fetch();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.fetch();

    expect(future, throwsA(DomainError.unexpected));
  });

  test(
      'Should throw InvalidDataError if HttpClient returns 200 with invalid data',
      () async {
    mockHttpData(mockDataWithoutResults());
    final future = sut.fetch();
    expect(future, throwsA(DomainError.invalidData));

    mockHttpData(mockDataWithoutNextAndPrevious());
    final future2 = sut.fetch();
    expect(future2, throwsA(DomainError.invalidData));
  });

  test('Should return PokemonList on 200', () async {
    final result = await sut.fetch();

    expect(
      result,
      PokemonListEntity(
        next: pokemonData['next'],
        previous: pokemonData['previous'],
        results: [
          PokemonResultEntity(
            name: pokemonData['results'][0]['name'],
            url: pokemonData['results'][0]['url'],
          ),
          PokemonResultEntity(
            name: pokemonData['results'][1]['name'],
            url: pokemonData['results'][1]['url'],
          ),
        ],
      ),
    );
  });
}
