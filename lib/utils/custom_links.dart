import 'package:url_launcher/url_launcher.dart';

class CustomLinks {
  final Uri _url = Uri.parse('https://portalprojetocrescer.org/');
  Future<void> entrarPortal() async {
    if (!await launchUrl(_url)) {
      throw Exception('Não consegui encontrar a $_url');
    }
  }

  final Uri _url2 = Uri.parse('http://projetocrescer.ddns.net/sistemaalunos');
  Future<void> entrarProfessor() async {
    if (!await launchUrl(_url2)) {
      throw Exception('Não consegui encontrar a $_url2');
    }
  }

  final Uri _urlFacebook =
      Uri.parse('https://www.facebook.com/casadobommeninodearapongas');
  Future<void> facebook() async {
    if (!await launchUrl(_urlFacebook)) {
      throw Exception('Não consegui encontrar a $_url');
    }
  }

  final Uri _urlYoutube =
      Uri.parse('https://www.youtube.com/c/ProjetoCrescerArapongas');
  Future<void> youtube() async {
    if (!await launchUrl(_urlYoutube, mode: LaunchMode.externalApplication)) {
      throw Exception('Não consegui encontrar a $_url');
    }
  }

  final Uri _urlInstagram =
      Uri.parse('https://www.instagram.com/casabommeninoarapongas/');
  Future<void> instagram() async {
    if (!await launchUrl(_urlInstagram)) {
      throw Exception('Não consegui encontrar a $_url');
    }
  }

  final Uri _urlTiktok =
      Uri.parse('https://www.tiktok.com/@projetocrescerarapongas');
  Future<void> tiktok() async {
    if (!await launchUrl(_urlTiktok)) {
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
    try {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw Exception('Não consegui encontrar a $_url: ' + e.toString());
    }
  }
}
