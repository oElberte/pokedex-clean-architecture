import 'package:equatable/equatable.dart';

class TypesEntity extends Equatable {
  final String types;

  const TypesEntity({
    required this.types,
  });

  @override
  List<Object?> get props => [types];
}
