import 'package:gif_service/gif_service.dart';

import 'models/gif_model.dart';

/// {@template gif_repository}
/// My Gif Repository
/// {@endtemplate}
class GifRepository {
  /// {@macro gif_repository}
  GifRepository({GifService? gifService})
      : _gifService = gifService ?? GifService();

  final GifService _gifService;

  Future<List<GifModel>> getUrls() async {
    final List<GifModel> urls = [];

    try {
      final listUrls = await _gifService.fetchGifs();

      for (final url in listUrls) {
        urls.add(GifModel(url));
      }
    } catch (_) {
      throw Exception();
    }

    return urls;
  }
}
