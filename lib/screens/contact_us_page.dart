import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetocrescer/utils/custom_links.dart';
import 'package:projetocrescer/widgets/contact_us_tile.dart';
import 'package:projetocrescer/widgets/show_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ContactUsPage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING";
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

CustomLinks links = CustomLinks();

class _ContactUsPageState extends State<ContactUsPage> {
  final GlobalKey globalKeyOne = GlobalKey();
  String phoneNumber = 'tel:433056-0777';

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(ContactUsPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          ContactUsPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result) ShowCaseWidget.of(context).startShowCase([globalKeyOne]);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowCaseView(
            globalKey: globalKeyOne,
            title: 'FALE CONOSCO',
            description:
                'Aqui, o pai ou responsável poderá encontrar facilmente o contato necessário para solucionar qualquer questão relacionada ao Projeto Crescer. Seja para falar com a secretaria, coordenação ou outro setor, todos os números importantes estarão disponíveis nesta tela.',
            border: CircleBorder(),
            child: Text('FALE CONOSCO')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        child: ListView(
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            //   margin: EdgeInsets.all(8),
            //   height: 115,
            //   width: MediaQuery.of(context).size.width,
            //   child: Text(
            //     'Aqui, o pai ou responsável poderá encontrar facilmente o contato necessário para solucionar qualquer questão relacionada ao Projeto Crescer. Seja para falar com a secretaria, coordenação ou outro setor, todos os números importantes estarão disponíveis nesta tela.',
            //     textAlign: TextAlign.justify,
            //     style: TextStyle(
            //       // backgroundColor: CustomColors.azul,
            //       color: Colors.black,
            //       fontSize: 16,
            //       fontFamily: 'Ubuntu',
            //     ),
            //   ),
            // ),
            ContactUsTile(
              icon: Icons.phone,
              color: Colors.green,
              title: 'TELEFONE FIXO PROJETO CRESCER I',
              subtitle: 'Telefone fixo secretaria Projeto \nCrescer I',
              ontap: () async {
                await links.makePhoneCall(phoneNumber);
              },
            ),
            ContactUsTile(
              icon: FontAwesomeIcons.whatsapp,
              color: Colors.green,
              title: 'COORDENAÇÃO PROJETO CRESCER I',
              subtitle: 'Whatsapp Coordenação Projeto Crescer I',
              ontap: () async {
                links.whatsapp('+5543988194541');
              },
            ),
            ContactUsTile(
              icon: FontAwesomeIcons.whatsapp,
              color: Colors.green,
              title: 'SECRETÁRIA PED. PROJETO CRESCER I',
              subtitle: 'Whatsapp Secretaria Pedagógica Projeto Crescer I',
              ontap: () async {
                links.whatsapp('+5543988299343');
              },
            ),
            ContactUsTile(
              icon: FontAwesomeIcons.whatsapp,
              color: Colors.green,
              title: 'SECRETÁRIA PED. PROJETO CRESCER II',
              subtitle: 'Whatsapp Secretaria Pedagógica Projeto Crescer II',
              ontap: () async {
                links.whatsapp('+5543999770311');
              },
            ),
          ],
        ),
      ),
    );
  }
}
