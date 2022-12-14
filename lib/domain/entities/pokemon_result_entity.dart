import 'package:equatable/equatable.dart';

class PokemonResultEntity extends Equatable {
  final String name;
  final String url;

  const PokemonResultEntity({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];
}
