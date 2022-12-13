import '../../domain/entities/entities.dart';
import '../http/http.dart';

class PokemonDetailsModel {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<StatsModel> stats;
  final List<TypeModel> types;

  const PokemonDetailsModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });

  factory PokemonDetailsModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'name', 'sprites'])) {
      throw HttpError.invalidData;
    }

    return PokemonDetailsModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      height: json['height'],
      weight: json['weight'],
      stats: json['stats']
          .map<StatsModel>((answer) => StatsModel.fromJson(answer))
          .toList(),
      types: json['types']
          .map<TypeModel>((answer) => TypeModel.fromJson(answer))
          .toList(),
    );
  }

  PokemonDetailsEntity toEntity() {
    return PokemonDetailsEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      height: height,
      weight: weight,
      stats: stats.map<StatsEntity>((answer) => answer.toEntity()).toList(),
      types: types.map<TypeEntity>((answer) => answer.toEntity()).toList(),
    );
  }
}

class StatsModel {
  final int stat;
  final String name;

  const StatsModel({
    required this.stat,
    required this.name,
  });

  factory StatsModel.fromJson(Map json) {
    return StatsModel(
      stat: json['base_stat'],
      name: json['stat']['name'],
    );
  }

  StatsEntity toEntity() {
    return StatsEntity(
      stat: stat,
      name: name,
    );
  }
}

class TypeModel {
  final String type;

  const TypeModel({
    required this.type,
  });

  factory TypeModel.fromJson(Map json) {
    return TypeModel(
      type: json['type']['name'],
    );
  }

  TypeEntity toEntity() {
    return TypeEntity(
      type: type,
    );
  }
}
