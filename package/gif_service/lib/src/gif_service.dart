/// {@template gif_service}
/// My Gif Service
/// {@endtemplate}
///
import 'dart:convert';

import 'package:http/http.dart' as http;

class GifService {
  /// {@macro gif_service}
  GifService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final String base_url = "api.giphy.com";
  final String endPoint = "/v1/gifs/trending";
  final String apiKey = "9K3xXUTJ5UVtFv5JDwKKnpfHVQZ8RJXF";

  Future<List<String>> fetchGifs() async {
    final uri = Uri.http(base_url, endPoint, {'api_key': apiKey});

    http.Response response;
    List body;

    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw Exception();
    }

    if (response.statusCode != 200) {
      throw HttpRequestException(
          'Ocurrio un error al obtener los gif', response.statusCode);
    }

    try {
      body = jsonDecode(response.body)['data'] as List;
    } on Exception {
      throw JsonDecodeException('Error al decodificar el JSON de con los gif');
    }

    return body
        .map((url) => url['images']['original']['url'].toString())
        .toList();
  }
}

class HttpRequestException implements Exception {
  final String message;
  final int statusCode;

  HttpRequestException(this.message, this.statusCode);

  @override
  String toString() {
    return 'HttpRequestException: $message ($statusCode)';
  }
}

class JsonDecodeException implements Exception {
  final String message;

  JsonDecodeException(this.message);

  @override
  String toString() {
    return 'HttpRequestException: $message';
  }
}
