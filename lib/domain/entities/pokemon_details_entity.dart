import 'package:equatable/equatable.dart';

import 'entities.dart';

class PokemonDetailsEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<StatsEntity> stats;
  final List<TypesEntity> types;

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
