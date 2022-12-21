import '../../domain/entities/entities.dart';
import '../http/http.dart';

class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<StatModel> stats;
  final List<String> types;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });

  factory PokemonModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'name', 'sprites', 'types'])) {
      throw HttpError.invalidData;
    }

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      height: json['height'],
      weight: json['weight'],
      stats: json['stats']
          .map<StatModel>((answer) => StatModel.fromJson(answer))
          .toList(),
      types: json['types'].map<String>((answer) => answer['type']['name'].toString()).toList(),
    );
  }

  PokemonEntity toEntity() {
    return PokemonEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      height: height,
      weight: weight,
      stats: stats.map<StatEntity>((answer) => answer.toEntity()).toList(),
      types: types,
    );
  }
}

class StatModel {
  final int stat;
  final String name;

  const StatModel({
    required this.stat,
    required this.name,
  });

  factory StatModel.fromJson(Map json) {
    return StatModel(
      stat: json['base_stat'],
      name: json['stat']['name'],
    );
  }

  StatEntity toEntity() {
    return StatEntity(
      stat: stat,
      name: name,
    );
  }
}
