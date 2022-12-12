import 'package:equatable/equatable.dart';

import 'pokemon_results_entity.dart';

class PokemonListEntity extends Equatable {
  final String? next;
  final String? previous;
  final List<PokemonResultsEntity> results;

  const PokemonListEntity({
    this.next,
    this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [next, previous, results];
}
