import '../entities/entities.dart';

abstract class LoadPokemonDetails {
  Future<List<PokemonDetailsEntity>> fetch(List<String> url);
}
