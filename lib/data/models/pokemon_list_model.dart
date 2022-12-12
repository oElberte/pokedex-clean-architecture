import 'pokemon_results_model.dart';

class PokemonListEntity {
  final String? next;
  final String? previous;
  final List<PokemonResultsModel> results;

  const PokemonListEntity({
    this.next,
    this.previous,
    required this.results,
  });
}
