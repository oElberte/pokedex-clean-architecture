class PokemonViewModel {
  final String? next;
  final String? previous;
  final String id;
  final String name;
  final String imageUrl;
  final String height;
  final String weight;
  final List<StatsViewModel> stats;
  final List<TypesViewModel> types;

  const PokemonViewModel({
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

class StatsViewModel {
  final int stat;
  final String name;

  const StatsViewModel({
    required this.stat,
    required this.name,
  });
}

class TypesViewModel {
  final String type;

  const TypesViewModel({
    required this.type,
  });
}
