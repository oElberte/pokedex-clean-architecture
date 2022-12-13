import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../http/http.dart';
import '../models/models.dart';

class LoadPokemonResultsImpl {
  final String url;
  final HttpClient httpClient;

  LoadPokemonResultsImpl({
    required this.url,
    required this.httpClient,
  });

  Future<PokemonResultsEntity> loadData() async {
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
