import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/load_pokemon.dart';
import '../http/http.dart';
import '../models/models.dart';

class LoadPokemonImpl implements LoadPokemon {
  final HttpClient httpClient;

  LoadPokemonImpl({required this.httpClient});

  @override
  Future<PokemonEntity> fetch(String id) async {
    try {
      final url = 'https://pokeapi.co/api/v2/pokemon/$id/';
      final json = await httpClient.request(url);
      return PokemonModel.fromJson(json).toEntity();
    } on HttpError catch (e) {
      switch (e) {
        case HttpError.badRequest:
          throw DomainError.badRequest;
        case HttpError.invalidData:
          throw DomainError.invalidData;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}
