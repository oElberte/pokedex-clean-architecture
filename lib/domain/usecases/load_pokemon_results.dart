import '../entities/entities.dart';

abstract class LoadPokemonResults {
  Future<List<PokemonResultsEntity>> loadData();
}
