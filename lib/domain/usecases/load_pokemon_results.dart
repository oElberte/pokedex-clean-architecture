import '../entities/entities.dart';

abstract class LoadPokemonResults {
  Future<PokemonResultsEntity> fetch();
}
