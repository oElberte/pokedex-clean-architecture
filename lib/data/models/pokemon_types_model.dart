import '../../domain/entities/entities.dart';

class TypesModel {
  final String types;

  const TypesModel({
    required this.types,
  });

  factory TypesModel.fromJson(Map json) {
    return TypesModel(types: json['type']['name']);
  }

  TypesEntity toEntity() {
    return TypesEntity(
      types: types,
    );
  }
}
