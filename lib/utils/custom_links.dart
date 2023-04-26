import 'package:url_launcher/url_launcher.dart';

class CustomLinks {
  final Uri _url = Uri.parse('https://portalprojetocrescer.org/');
  Future<void> entrarPortal() async {
    if (!await launchUrl(_url)) {
      throw Exception('Não consegui encontrar a $_url');
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void whatsapp(String numero) async {
    final Uri _url = Uri.parse(
        'https://api.whatsapp.com/send?phone=$numero&text=Ol%C3%A1,%20tudo%20bem?%20Vim%20pelo%20aplicativo.%20Gostaria%20de%20saber%20sobre...');
    if (await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Não consegui encontrar a $_url');
    }
  }
}
