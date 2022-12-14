import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/load_pokemon_results.dart';
import '../http/http.dart';
import '../models/models.dart';

class LoadPokemonResultsImpl implements LoadPokemonResults {
  final HttpClient httpClient;

  LoadPokemonResultsImpl({
    required this.httpClient,
  });

  @override
  Future<List<PokemonResultEntity>> fetch(List<String> url) async {
    try {
      List<PokemonResultEntity> list = [];
      for (var element in url) {
        final json = await httpClient.request(element);
        final entity = PokemonResultModel.fromJson(json).toEntity();
        list.add(entity);
      }
      return list;
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
