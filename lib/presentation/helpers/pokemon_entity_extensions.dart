import 'string_extensions.dart';

import '../../domain/entities/entities.dart';
import '../../ui/components/components.dart';

extension PokemonEntityExtensions on PokemonEntity {
  PokemonViewModel toViewModel() {
    return PokemonViewModel(
      id: id.toString().fixId(),
      name: name.toUpperCase().removeAdditional(),
      imageUrl: imageUrl,
      height: height.toString(),
      weight: weight.toString(),
      stats: stats
          .map((e) => StatViewModel(
                stat: e.stat,
                name: e.name.toUpperCase(),
              ))
          .toList(),
      types: types.map((e) => e.toUpperCase()).toList(),
    );
  }
}
