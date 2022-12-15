import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/presenters/presenters.dart';

import 'stream_pokemon_presenter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoadPokemon>()])
void main() {
  late StreamPokemonPresenter sut;
  late MockLoadPokemon loadPokemon;

  setUp(() {
    loadPokemon = MockLoadPokemon();
    sut = StreamPokemonPresenter(loadPokemon);
  });

  test('Should call fetch on loadData', () async {
    await sut.loadData();

    verify(loadPokemon.fetch()).called(1);
  });
}
