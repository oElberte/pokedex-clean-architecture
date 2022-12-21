import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadPokemon makeLoadPokemon() {
  return LoadPokemonImpl(
    httpClient: makeHttpAdapter(),
  );
}
