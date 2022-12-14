import 'package:equatable/equatable.dart';

import 'pokemon_result_entity.dart';

class PokemonListEntity extends Equatable {
  final String? next;
  final String? previous;
  final List<PokemonResultEntity> results;

  const PokemonListEntity({
    this.next,
    this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [next, previous, results];
}
