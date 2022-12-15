import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pokedex/data/http/http.dart';

import 'package:pokedex/infra/http/http.dart';

import 'http_adapter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  late HttpAdapter sut;
  late MockClient client;
  late String url;

  PostExpectation mockRequest() => when(client.get(any));

  void mockResponse(int statusCode, {String body = '{"any":"any"}'}) {
    mockRequest().thenAnswer((_) async => Response(body, statusCode));
  }

  void mockError() {
    mockRequest().thenThrow(Exception());
  }

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    mockResponse(200);
  });

  test('Should call get with correct url', () async {
    await sut.request(url);

    verify(client.get(Uri.parse(url)));
  });

  test('Should return data if get returns 200', () async {
    final response = await sut.request(url);

    expect(response, {'any': 'any'});
  });

  test('Should throw InvalidDataError if get returns 200 w/o data', () async {
    mockResponse(200, body: '');

    final response = sut.request(url);

    expect(response, throwsA(HttpError.invalidData));
  });

  test('Should throw InvalidDataError if get returns 204', () async {
    mockResponse(204, body: '');

    final response = sut.request(url);

    expect(response, throwsA(HttpError.invalidData));
  });

  test('Should throw InvalidDataError if get returns 204 with data', () async {
    mockResponse(204);

    final response = sut.request(url);

    expect(response, throwsA(HttpError.invalidData));
  });

  test('Should throw BadRequestError if get returns 400 w/o body', () async {
    mockResponse(400, body: '');

    final future = sut.request(url);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should throw BadRequestError if get returns 400', () async {
    mockResponse(400);

    final future = sut.request(url);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should throw NotFoundError if get returns 404', () async {
    mockResponse(404);

    final future = sut.request(url);

    expect(future, throwsA(HttpError.notFound));
  });

  test('Should throw ServerError if get returns 500', () async {
    mockResponse(500);

    final future = sut.request(url);

    expect(future, throwsA(HttpError.serverError));
  });

  test('Should throw ServerError if get throws', () async {
    mockError();

    final future = sut.request(url);

    expect(future, throwsA(HttpError.serverError));
  });
}
