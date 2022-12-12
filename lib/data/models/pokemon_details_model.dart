class PokemonDetailsModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<StatsModel> stats;
  final List<TypesModel> types;

  const PokemonDetailsModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });
}

class TypesModel {
  final String types;

  const TypesModel({
    required this.types,
  });
}

class StatsModel {
  final int stat;
  final String name;

  const StatsModel({
    required this.stat,
    required this.name,
  });
}