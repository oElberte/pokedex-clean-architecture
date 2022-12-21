import 'package:equatable/equatable.dart';

class PokemonViewModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String height;
  final String weight;
  final List<StatViewModel> stats;
  final List<String> types;

  const PokemonViewModel({
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