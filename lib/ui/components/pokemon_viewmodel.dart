import 'package:equatable/equatable.dart';

class PokemonViewModel extends Equatable {
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

  @override
  List<Object?> get props => [
        next,
        previous,
        id,
        name,
        imageUrl,
        height,
        weight,
        stats,
        types,
      ];
}

class StatViewModel extends Equatable {
  final int stat;
  final String name;

  const StatViewModel({
    required this.stat,
    required this.name,
  });
  
  @override
  List<Object?> get props => [stat, name];
}

class TypeViewModel extends Equatable {
  final String type;

  const TypeViewModel({
    required this.type,
  });

   @override
  List<Object?> get props => [type];
}
