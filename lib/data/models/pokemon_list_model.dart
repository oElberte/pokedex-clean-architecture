import '../http/http.dart';

import '../../domain/entities/entities.dart';
import 'pokemon_results_model.dart';

class PokemonListModel {
  final String? next;
  final String? previous;
  final List<PokemonResultsModel> results;

  const PokemonListModel({
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListModel.fromJson(Map json) {
    if (!json.keys.toSet().contains('results')) {
      throw HttpError.invalidData;
    } else if (!json.keys.toSet().containsAll(['next', 'previous'])) {
      throw HttpError.invalidData;
    }

    return PokemonListModel(
      next: json['next'],
      previous: json['previous'],
      results: json['results']
          .map<PokemonResultsModel>(
            (answerJson) => PokemonResultsModel.fromJson(answerJson),
          )
          .toList(),
    );
  }

  PokemonListEntity toEntity() {
    return PokemonListEntity(
      next: next,
      previous: previous,
      results: results
          .map<PokemonResultsEntity>((answer) => answer.toEntity())
          .toList(),
    );
  }
}
