import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/widgets/show_case.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../utils/constants.dart';

class BadgePage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING_BADGE";
  const BadgePage({super.key});

  @override
  State<BadgePage> createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  final GlobalKey globalKeySeven = GlobalKey();

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(BadgePage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          BadgePage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result) ShowCaseWidget.of(context).startShowCase([globalKeySeven]);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowCaseView(
            globalKey: globalKeySeven,
            title: 'CRACHÁ',
            description:
                'Nesta tela, você pode visualizar e acessar o seu crachá escolar de forma prática e rápida. O crachá é uma identificação importante.',
            border: CircleBorder(),
            child: Text('CRACHÁ')),
      ),
      body: Center(
        child: Cracha(),
      ),
    );
  }
}

class Cracha extends StatefulWidget {
  @override
  State<Cracha> createState() => _CrachaState();
}

class _CrachaState extends State<Cracha> {
  late bool fotoExiste;

  late String foto;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final providerFoto = Provider.of<Login>(context).foto.toString();
    fotoExiste = providerFoto != 'null';
    foto = Constants.URL_FOTOS + providerFoto;
  }

  @override
  Widget build(BuildContext context) {
    var nomeCompleto = Provider.of<Login>(context).usuarioMatricula.toString();
    var serie = Provider.of<Login>(context).serie.toString();
    var nomeSeparado = nomeCompleto.split(' ');
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 12, right: 12),
      width: double.infinity,
      child: Card(
        shadowColor: Colors.black,
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.50,
              height: size.width * 0.50,
              child: fotoExiste
                  ? Image.network(
                      foto,
                    )
                  : Image.asset('images/avatar.png'),
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              nomeSeparado[0],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // SizedBox(height: 10),
            Text(
              nomeSeparado[nomeSeparado.length - 1],
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 22,
              ),
            ),
            Text(
              serie +
                  (serie == 'oficineiro' ? 'oficineiro' : 'º ANO')
                      .toUpperCase(),
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 22,
              ),
            ),
            SizedBox(height: 20),
            QrImageView(
              data: Provider.of<Login>(context).qrCode.toString(),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
