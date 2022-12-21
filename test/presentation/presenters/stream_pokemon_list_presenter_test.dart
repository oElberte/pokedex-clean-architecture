import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/helpers/domain_error.dart';
import 'package:pokedex/domain/usecases/usecases.dart';
import 'package:pokedex/presentation/helpers/helpers.dart';
import 'package:pokedex/presentation/presenters/presenters.dart';
import 'package:pokedex/ui/components/components.dart';
import 'package:pokedex/ui/helpers/helpers.dart';

import 'stream_pokemon_list_presenter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoadPokemon>()])
void main() {
  late MockLoadPokemon loadPokemon;
  late StreamPokemonListPresenter sut;
  late PokemonEntity pokemonEntity;

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
        height: pokemonEntity.height.toString(),
        weight: pokemonEntity.weight.toString(),
        stats: [
          StatViewModel(
            stat: pokemonEntity.stats[0].stat,
            name: pokemonEntity.stats[0].name.toUpperCase(),
          ),
          StatViewModel(
            stat: pokemonEntity.stats[1].stat,
            name: pokemonEntity.stats[1].name.toUpperCase(),
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

  tearDown(() => sut.dispose());

  setUp(() {
    loadPokemon = MockLoadPokemon();
    sut = StreamPokemonListPresenter(loadPokemon);
    mockLoadData(makePokemonEntity());
  });

  test('Should call fetch on loadData', () async {
    await sut.loadData();

    verify(loadPokemon.fetch(any)).called(50);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.pokemonStream, emits(List.generate(50, (_) => makePokemonViewModel())));

    await sut.loadData();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockLoadDataError(DomainError.unexpected);

    expectLater(sut.pokemonStream, emitsError(UIError.unexpected.description));

    await sut.loadData();
  });

  test('Should emit correct events on InvalidData', () async {
    mockLoadDataError(DomainError.invalidData);

    expectLater(sut.pokemonStream, emitsError(UIError.invalidData.description));

    await sut.loadData();
  });

  test('Should emit correct events on BadRequest', () async {
    mockLoadDataError(DomainError.badRequest);

    expectLater(sut.pokemonStream, emitsError(UIError.badRequest.description));

    await sut.loadData();
  });
}
