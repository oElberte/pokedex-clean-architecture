import 'package:hive/hive.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

HandleFavorite makeHandleFavorite() {
  return HandleFavoriteImpl(Hive);
}
