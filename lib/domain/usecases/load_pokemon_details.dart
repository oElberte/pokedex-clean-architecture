import '../entities/entities.dart';

abstract class LoadPokemonDetails {
  Future<PokemonDetailsEntity> fetch({required String url});
}
