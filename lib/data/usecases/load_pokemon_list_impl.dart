import '../../domain/helpers/helpers.dart';
import '../http/http.dart';

class LoadPokemonListImpl {
  final String url;
  final HttpClient httpClient;

  LoadPokemonListImpl({
    required this.url,
    required this.httpClient,
  });

  Future<void> loadData() async {
    try {
      await httpClient.request(url);
    } on HttpError catch (e) {
      e == HttpError.badRequest
          ? throw DomainError.badRequest
          : throw DomainError.unexpected;
    }
  }
}
