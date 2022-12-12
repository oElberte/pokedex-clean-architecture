import 'package:equatable/equatable.dart';

class PokemonResultsEntity extends Equatable {
  final String name;
  final String url;

  const PokemonResultsEntity({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];
}
