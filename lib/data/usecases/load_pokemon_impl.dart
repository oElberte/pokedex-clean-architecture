import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/usecases.dart';

class LoadPokemonImpl implements LoadPokemon {
  @override
  final LoadPokemonList loadList;
  @override
  final LoadPokemonDetails loadDetails;

  LoadPokemonImpl({
    required this.loadList,
    required this.loadDetails,
  });

  /*  Since the PokeAPI separes everything of Pokémons,
      I splitted my use cases to fetch each part of the API separated,
      and this use case unit the most of them.
  */
  @override
  Future<List<PokemonEntity>> fetch({String? nextUrl}) async {
    List<PokemonEntity> pokemonList = [];

    final list = await loadList.fetch(nextUrl: nextUrl);
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
