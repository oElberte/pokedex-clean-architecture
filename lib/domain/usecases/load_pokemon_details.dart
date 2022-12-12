import '../entities/entities.dart';

abstract class LoadPokemonDetails {
  Future<PokemonDetailsEntity> loadData({required String url});
}
