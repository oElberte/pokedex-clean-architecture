import 'string_extensions.dart';

import '../../domain/entities/entities.dart';
import '../../ui/components/components.dart';

extension PokemonEntityExtensions on PokemonEntity {
  PokemonViewModel toViewModel() {
    return PokemonViewModel(
      next: next,
      previous: previous,
      id: id.toString(),
      name: name.capitalize().removeGender(),
      imageUrl: imageUrl,
      height: height.toString(),
      weight: weight.toString(),
      stats: stats
          .map((e) => StatViewModel(
                stat: e.stat,
                name: e.name.capitalize(),
              ))
          .toList(),
      types: types
          .map((e) => TypeViewModel(
                type: e.type.capitalize(),
              ))
          .toList(),
    );
  }
}
