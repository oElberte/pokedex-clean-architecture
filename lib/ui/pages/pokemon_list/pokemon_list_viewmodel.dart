import './pokemon_results_viewmodel.dart';

class PokemonListViewModel {
  final String? next;
  final String? previous;
  final List<PokemonResultsViewModel> results;

  PokemonListViewModel({
    this.next,
    this.previous,
    required this.results,
  });
}
