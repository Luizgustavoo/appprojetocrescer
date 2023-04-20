import 'package:url_launcher/url_launcher.dart';

class CustomLinks {
  final Uri _url = Uri.parse('https://portalprojetocrescer.org/');
  Future<void> entrarPortal() async {
    if (!await launchUrl(_url)) {
      throw Exception('Não consegui encontrar a $_url');
    }
  }
}
