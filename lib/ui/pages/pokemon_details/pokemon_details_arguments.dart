import '../../components/components.dart';

class PokemonDetailsArguments {
  final int index;
  final List<PokemonViewModel> viewModels;

  PokemonDetailsArguments({
    required this.index,
    required this.viewModels,
  });
}
