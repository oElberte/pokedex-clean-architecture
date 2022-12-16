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

import 'stream_pokemon_presenter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoadPokemon>()])
void main() {
  late MockLoadPokemon loadPokemon;
  late StreamPokemonPresenter sut;
  late List<PokemonEntity> pokemonEntityList;

  List<PokemonEntity> makePokemonEntityList() => [
        PokemonEntity(
          next: faker.internet.httpUrl(),
          previous: null,
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
            TypeEntity(
              type: faker.randomGenerator.string(10),
            ),
            TypeEntity(
              type: faker.randomGenerator.string(10),
            ),
          ],
        ),
      ];

  List<PokemonViewModel> makePokemonViewModelList() => [
        PokemonViewModel(
          next: pokemonEntityList[0].next,
          previous: pokemonEntityList[0].previous,
          id: pokemonEntityList[0].id.toString(),
          name: pokemonEntityList[0].name.capitalize().removeGender(),
          imageUrl: pokemonEntityList[0].imageUrl,
          height: pokemonEntityList[0].height.toString(),
          weight: pokemonEntityList[0].weight.toString(),
          stats: [
            StatViewModel(
              stat: pokemonEntityList[0].stats[0].stat,
              name: pokemonEntityList[0].stats[0].name.capitalize(),
            ),
            StatViewModel(
              stat: pokemonEntityList[0].stats[1].stat,
              name: pokemonEntityList[0].stats[1].name.capitalize(),
            ),
          ],
          types: [
            TypeViewModel(
              type: pokemonEntityList[0].types[0].type.capitalize(),
            ),
            TypeViewModel(
              type: pokemonEntityList[0].types[1].type.capitalize(),
            ),
          ],
        ),
      ];

  PostExpectation mockLoadDataCall() => when(loadPokemon.fetch());

  void mockLoadData(List<PokemonEntity> data) {
    pokemonEntityList = data;
    mockLoadDataCall().thenAnswer((_) async => pokemonEntityList);
  }

  void mockLoadDataError(DomainError error) =>
      mockLoadDataCall().thenThrow(error);

  tearDown(() => sut.dispose());

  setUp(() {
    loadPokemon = MockLoadPokemon();
    sut = StreamPokemonPresenter(loadPokemon);
    mockLoadData(makePokemonEntityList());
  });

  test('Should call fetch on loadData', () async {
    await sut.loadData();

    verify(loadPokemon.fetch()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.pokemonStream, emits(makePokemonViewModelList()));
    sut.pokemonErrorStream.listen(expectAsync1((error) => expect(error, null)));

    await sut.loadData();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockLoadDataError(DomainError.unexpected);

    expectLater(sut.isLoadingStream, emits(false));
    sut.pokemonErrorStream.listen(expectAsync1(
      (error) => expect(error, UIError.unexpected.description),
    ));

    await sut.loadData();
  });

  test('Should emit correct events on InvalidData', () async {
    mockLoadDataError(DomainError.invalidData);

    expectLater(sut.isLoadingStream, emits(false));
    sut.pokemonErrorStream.listen(expectAsync1(
      (error) => expect(error, UIError.invalidData.description),
    ));

    await sut.loadData();
  });

  test('Should emit correct events on BadRequest', () async {
    mockLoadDataError(DomainError.badRequest);

    expectLater(sut.isLoadingStream, emits(false));
    sut.pokemonErrorStream.listen(expectAsync1(
      (error) => expect(error, UIError.badRequest.description),
    ));

    await sut.loadData();
  });
}
