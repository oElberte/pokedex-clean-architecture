import 'string_extensions.dart';

import '../../domain/entities/entities.dart';
import '../../ui/components/components.dart';

extension PokemonEntityExtensions on PokemonEntity {
  PokemonViewModel toViewModel() {
    return PokemonViewModel(
      next: next,
      previous: previous,
      id: id.toString().fixId(),
      name: name.toUpperCase().removeGender(),
      imageUrl: imageUrl,
      height: height.toString(),
      weight: weight.toString(),
      stats: stats
          .map((e) => StatViewModel(
                stat: e.stat,
                name: e.name.toUpperCase(),
              ))
          .toList(),
      types: types.map((e) => e.type.toUpperCase()).toList(),
    );
  }
}
