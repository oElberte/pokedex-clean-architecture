import '../../domain/entities/entities.dart';
import '../http/http.dart';
import 'pokemon_result_model.dart';

class PokemonListModel {
  final String? next;
  final String? previous;
  final List<PokemonResultModel> results;

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
          .map<PokemonResultModel>(
              (answer) => PokemonResultModel.fromJson(answer))
          .toList(),
    );
  }

  PokemonListEntity toEntity() {
    return PokemonListEntity(
      next: next,
      previous: previous,
      results: results
          .map<PokemonResultEntity>((answer) => answer.toEntity())
          .toList(),
    );
  }
}
