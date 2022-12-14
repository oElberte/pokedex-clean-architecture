class PokemonViewModel {
  final String? next;
  final String? previous;
  final String id;
  final String name;
  final String imageUrl;
  final String height;
  final String weight;
  final List<StatViewModel> stats;
  final List<TypeViewModel> types;

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

class StatViewModel {
  final int stat;
  final String name;

  const StatViewModel({
    required this.stat,
    required this.name,
  });
}

class TypeViewModel {
  final String type;

  const TypeViewModel({
    required this.type,
  });
}
