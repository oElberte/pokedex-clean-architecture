import '../http/http.dart';

class LoadPokemonListImpl {
  final String url;
  final HttpClient httpClient;

  LoadPokemonListImpl({
    required this.url,
    required this.httpClient,
  });

  Future<void> loadData() async {
    await httpClient.request(url);
  }
}
