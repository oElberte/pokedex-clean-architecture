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
  late LoadPokemonResultsImpl sut;
  late Map pokemonData;

  Map mockDataWithoutName() => {
        'url': faker.internet.httpUrl(),
      };

  Map mockDataWithoutUrl() => {
        'name': faker.animal.name(),
      };

  Map mockValidData() => {
        'name': faker.animal.name(),
        'url': faker.internet.httpUrl(),
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
    sut = LoadPokemonResultsImpl(
      httpClient: httpClient,
    );
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
    mockHttpData(mockDataWithoutName());
    final future = sut.fetch(urlList);
    expect(future, throwsA(DomainError.invalidData));

    mockHttpData(mockDataWithoutUrl());
    final future2 = sut.fetch(urlList);
    expect(future2, throwsA(DomainError.invalidData));
  });

  test('Should return PokemonResults on 200', () async {
    final result = await sut.fetch(urlList);

    expect(result, [
      PokemonResultEntity(
        name: pokemonData['name'],
        url: pokemonData['url'],
      ),
    ]);
  });
}
