import 'package:pokedex_clean_architecture/data/http/http.dart';
import 'package:pokedex_clean_architecture/domain/entities/entities.dart';

import '../../domain/helpers/helpers.dart';
import '../models/models.dart';

class LoadPokemonDetailsImpl {
  final HttpClient httpClient;

  LoadPokemonDetailsImpl({
    required this.httpClient,
  });

  Future<PokemonDetailsEntity> loadData({required String url}) async {
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
