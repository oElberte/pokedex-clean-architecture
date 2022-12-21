import 'dart:convert';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request(String url) async {
    Response response = Response('', 500);

    try {
      final uri = Uri.parse(url);
      response = await client.get(uri).timeout(const Duration(seconds: 5));
    } catch (e) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty
            ? throw HttpError.invalidData
            : jsonDecode(response.body);
      case 204:
        throw HttpError.invalidData;
      case 400:
        throw HttpError.badRequest;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
