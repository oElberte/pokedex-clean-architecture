import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadPokemonDetails makeLoadPokemonDetails() {
  return LoadPokemonDetailsImpl(
    httpClient: makeHttpAdapter(),
  );
}
