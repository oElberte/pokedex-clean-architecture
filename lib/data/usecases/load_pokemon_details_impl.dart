import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/load_pokemon_details.dart';
import '../http/http.dart';
import '../models/models.dart';

class LoadPokemonDetailsImpl implements LoadPokemonDetails {
  final HttpClient httpClient;

  LoadPokemonDetailsImpl({
    required this.httpClient,
  });

  @override
  Future<PokemonDetailsEntity> fetch({required String url}) async {
    try {
      final json = await httpClient.request(url);
      return PokemonDetailsModel.fromJson(json).toEntity();
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
