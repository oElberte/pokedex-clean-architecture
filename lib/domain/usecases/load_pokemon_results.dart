import '../entities/entities.dart';

abstract class LoadPokemonResults {
  Future<List<PokemonResultEntity>> fetch(List<String> url);
}
