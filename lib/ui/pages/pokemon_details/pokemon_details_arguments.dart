import '../../components/components.dart';
import '../pages.dart';

class PokemonDetailsArguments {
  final PokemonListPresenter listPresenter;
  final List<PokemonViewModel> viewModels;
  final int tappedIndex;

  PokemonDetailsArguments({
    required this.listPresenter,
    required this.viewModels,
    required this.tappedIndex,
  });
}
