import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/load_pokemon.dart';
import '../factories.dart';

LoadPokemon makeLoadPokemon() {
  return LoadPokemonImpl(
    loadList: makeLoadPokemonList(),
    loadDetails: makeLoadPokemonDetails(),
  );
}
