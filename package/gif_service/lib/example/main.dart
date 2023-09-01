import '../gif_service.dart';

Future<void> main() async {
  final gifService = GifService();

  final urls = await gifService.fetchGifs();
  for (final url in urls) {
    print(url);
  }
}
