import '../entities/entities.dart';

abstract class LoadPokemonList {
  Future<PokemonListEntity> fetch();
}