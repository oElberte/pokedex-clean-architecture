import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/load_pokemon_results.dart';
import '../http/http.dart';
import '../models/models.dart';

class LoadPokemonResultsImpl implements LoadPokemonResults {
  final String url;
  final HttpClient httpClient;

  LoadPokemonResultsImpl({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<PokemonResultsEntity> fetch() async {
    try {
      final json = await httpClient.request(url);
      return PokemonResultsModel.fromJson(json).toEntity();
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
