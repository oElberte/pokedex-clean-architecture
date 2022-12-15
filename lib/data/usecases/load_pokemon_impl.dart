import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/usecases.dart';

class LoadPokemonImpl implements LoadPokemon {
  final LoadPokemonList loadList;
  final LoadPokemonDetails loadDetails;

  LoadPokemonImpl({
    required this.loadList,
    required this.loadDetails,
  });

  @override
  Future<List<PokemonEntity>> fetch() async {
    List<PokemonEntity> pokemonList = [];

    final list = await loadList.fetch();
    final urlList = list.results.map((result) => result.url).toList();
    final pokemonDetailsList = await loadDetails.fetch(urlList);

    for (var pokemon in pokemonDetailsList) {
      final entity = PokemonEntity(
        next: list.next,
        previous: list.previous,
        id: pokemon.id,
        name: pokemon.name,
        imageUrl: pokemon.imageUrl,
        height: pokemon.height,
        weight: pokemon.weight,
        stats: pokemon.stats,
        types: pokemon.types,
      );
      pokemonList.add(entity);
    }

    return pokemonList;
  }
}
