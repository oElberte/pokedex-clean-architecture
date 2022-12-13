import 'package:equatable/equatable.dart';

class StatsEntity extends Equatable {
  final int stat;
  final String name;

  const StatsEntity({
    required this.stat,
    required this.name,
  });

  @override
  List<Object?> get props => [stat, name];
}
