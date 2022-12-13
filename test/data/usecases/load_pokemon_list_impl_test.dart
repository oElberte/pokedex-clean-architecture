import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_clean_architecture/data/http/http.dart';

import 'package:pokedex_clean_architecture/data/usecases/usecases.dart';
import 'package:pokedex_clean_architecture/domain/helpers/helpers.dart';

import 'load_pokemon_list_impl_test.mocks.dart';

void main() {
  late String url;
  late MockHttpClient httpClient;
  late LoadPokemonListImpl sut;

  PostExpectation mockRequest() => when(httpClient.request(any));

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = MockHttpClient();
    sut = LoadPokemonListImpl(
      url: url,
      httpClient: httpClient,
    );
  });

  test('Shoud call HttpClient on loadData', () async {
    await sut.loadData();

    verify(httpClient.request(url)).called(1);
  });

  test('Should throw BadRequestError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.loadData();

    expect(future, throwsA(DomainError.badRequest));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.loadData();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.loadData();

    expect(future, throwsA(DomainError.unexpected));
  });
}
