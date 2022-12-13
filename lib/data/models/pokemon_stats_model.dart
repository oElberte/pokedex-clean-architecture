import '../../domain/entities/entities.dart';

class StatsModel {
  final int stat;
  final String name;

  const StatsModel({
    required this.stat,
    required this.name,
  });

  factory StatsModel.fromJson(Map json) {
    return StatsModel(stat: json['base_stat'], name: json['stat']['name']);
  }

  StatsEntity toEntity() {
    return StatsEntity(
      stat: stat,
      name: name,
    );
  }
}
