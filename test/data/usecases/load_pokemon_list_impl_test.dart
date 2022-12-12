import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:pokedex_clean_architecture/data/usecases/usecases.dart';

import 'load_pokemon_list_impl_test.mocks.dart';

void main() {
  late String url;
  late MockHttpClient httpClient;
  late LoadPokemonListImpl sut;

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
}
