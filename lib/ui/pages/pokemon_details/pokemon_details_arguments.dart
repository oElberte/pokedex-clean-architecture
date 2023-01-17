import '../../components/components.dart';
import '../pages.dart';

class PokemonDetailsArguments {
  final int tappedIndex;
  final List<PokemonViewModel> viewModels;
  final PokemonListPresenter? listPresenter;

  PokemonDetailsArguments({
    required this.tappedIndex,
    required this.viewModels,
    this.listPresenter,
  });
}
