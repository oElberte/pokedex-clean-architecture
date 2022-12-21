import '../entities/entities.dart';

abstract class LoadPokemon {
  Future<PokemonEntity> fetch(String id);
}
