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
  Future<List<PokemonDetailsEntity>> fetch(List<String> url) async {
    try {
      List<PokemonDetailsEntity> list = [];
      for (var element in url) {
        final json = await httpClient.request(element);
        final entity = PokemonDetailsModel.fromJson(json).toEntity();
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
