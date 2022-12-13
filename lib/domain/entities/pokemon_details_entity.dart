import 'package:equatable/equatable.dart';

class PokemonDetailsEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<StatsEntity> stats;
  final List<TypeEntity> types;

  const PokemonDetailsEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });

  @override
  List<Object?> get props => [id, name, height, weight, stats, types];
}

class StatsEntity extends Equatable {
  final int stat;
  final String name;

  const StatsEntity({
    required this.stat,
    required this.name,
  });

  @override
  List<Object?> get props => [stat, name];
}

class TypeEntity extends Equatable {
  final String type;

  const TypeEntity({
    required this.type,
  });
  
  @override
  List<Object?> get props => [type];
}
