import '../../domain/entities/entities.dart';
import '../http/http.dart';

class PokemonResultsModel {
  final String name;
  final String url;

  const PokemonResultsModel({
    required this.name,
    required this.url,
  });

  factory PokemonResultsModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['name', 'url'])) {
      throw HttpError.invalidData;
    }
    
    return PokemonResultsModel(
      name: json['name'],
      url: json['url'],
    );
  }

  PokemonResultsEntity toEntity() {
    return PokemonResultsEntity(
      name: name,
      url: url,
    );
  }
}
