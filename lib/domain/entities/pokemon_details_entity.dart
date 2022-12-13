import 'package:equatable/equatable.dart';

class PokemonDetailsEntity extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<StatsEntity> stats;
  final List<TypesEntity> types;

  const PokemonDetailsEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });

  @override
  List<Object?> get props => [id, name, height, weight, stats, types];
}

class TypesEntity extends Equatable {
  final String types;

  const TypesEntity({
    required this.types,
  });

  @override
  List<Object?> get props => [types];
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
