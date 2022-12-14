import '../../domain/entities/entities.dart';
import '../http/http.dart';

class PokemonResultModel {
  final String name;
  final String url;

  const PokemonResultModel({
    required this.name,
    required this.url,
  });

  factory PokemonResultModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['name', 'url'])) {
      throw HttpError.invalidData;
    }

    return PokemonResultModel(
      name: json['name'],
      url: json['url'],
    );
  }

  PokemonResultEntity toEntity() {
    return PokemonResultEntity(
      name: name,
      url: url,
    );
  }
}
