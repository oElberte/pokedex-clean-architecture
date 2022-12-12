import 'package:equatable/equatable.dart';

class PokemonDetailsEntity extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<Stats> stats;
  final List<Type> types;

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

class Types extends Equatable {
  final String types;

  const Types({
    required this.types,
  });

  @override
  List<Object?> get props => [types];
}

class Stats extends Equatable {
  final int stat;
  final String name;

  const Stats({
    required this.stat,
    required this.name,
  });

  @override
  List<Object?> get props => [stat, name];
}
