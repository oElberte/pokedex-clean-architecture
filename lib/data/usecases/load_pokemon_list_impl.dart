import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../http/http.dart';
import '../models/models.dart';

class LoadPokemonListImpl {
  final String url;
  final HttpClient httpClient;

  LoadPokemonListImpl({
    required this.url,
    required this.httpClient,
  });

  Future<PokemonListEntity> loadData() async {
    try {
      final json = await httpClient.request(url);
      return PokemonListModel.fromJson(json).toEntity();
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
