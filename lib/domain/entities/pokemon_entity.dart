import 'pokemon_details_entity.dart';

class PokemonEntity {
  final String? next;
  final String? previous;
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<StatEntity> stats;
  final List<TypeEntity> types;

  const PokemonEntity({
    this.next,
    this.previous,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });
}
