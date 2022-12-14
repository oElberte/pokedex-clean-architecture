import 'package:pokedex_clean_architecture/domain/entities/pokemon_entity.dart';

abstract class LoadPokemon {
  Future<List<PokemonEntity>> fetch();
}
