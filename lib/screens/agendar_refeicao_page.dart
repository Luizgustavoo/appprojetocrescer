import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/refeicao_tile.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

import '../utils/app_route.dart';

class AgendarRefeicao extends StatefulWidget {
  @override
  State<AgendarRefeicao> createState() => _AgendarRefeicaoState();
}

String qrCodeResult = "Aguardando...";
String codeInvalido = "";
bool resultInternet = false;
bool _isLoading = true;
StreamSubscription<ConnectivityResult>? _connectivitySubscription;

class _AgendarRefeicaoState extends State<AgendarRefeicao> {
  //*--------------CHECANDO CONEXAO COM A INTERNET ----------------
  void _updateStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        resultInternet = true;
      });
      updateText("3G/4G");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        resultInternet = true;
      });
      updateText("Conectado via wi-fi");
    } else {
      setState(() {
        resultInternet = false;
      });
      updateText("Atenção, você não tem uma conexão válida!");
    }
  }

  void updateText(String texto) {
    setState(() {
      _isLoading = false;
    });
  }

//*-------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamento'.toUpperCase()),
      ),
      body: /*_isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )*/
          Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await BarcodeScanner.scan().then((value) {
                    var jsonTEMP = jsonDecode(
                        utf8.decode(base64Url.decode(value.rawContent)));

                    print(jsonTEMP['matricula']);

                    if (jsonTEMP['matricula'] == null ||
                        jsonTEMP['nome'] == null ||
                        jsonTEMP['periodo'] == null ||
                        jsonTEMP['tipo'] == null) {
                      setState(() {
                        codeInvalido = "QR Code INVÁLIDO!";
                      });
                    } else {
                      setState(() {
                        codeInvalido = "";
                      });
                      Navigator.of(context).pushNamed(
                          AppRoute.OPCOES_AGENDAMENTO,
                          arguments: value.rawContent);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: CustomColors.azul,
                ),
                icon: Icon(
                  FontAwesomeIcons.utensils,
                  color: Colors.white,
                ),
                label: Text(
                  'AGENDAR REFEIÇÃO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, i) {
                return AnimationConfiguration.staggeredList(
                  position: i,
                  duration: Duration(milliseconds: 100),
                  child: ScaleAnimation(
                    duration: Duration(milliseconds: 500),
                    child: AgendarTile(
                      data: '23/05/2023',
                      cafe: 'CAFE',
                      almoco: 'ALMOCO',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
