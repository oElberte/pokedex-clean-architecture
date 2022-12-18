import '../entities/pokemon_entity.dart';
import 'usecases.dart';

abstract class LoadPokemon {
  final LoadPokemonList loadList;
  final LoadPokemonDetails loadDetails;

  LoadPokemon({
    required this.loadList,
    required this.loadDetails,
  });

  Future<List<PokemonEntity>> fetch({String? nextUrl});
}
