import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
StreamSubscription<ConnectivityResult> _connectivitySubscription;

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text(
            texto,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Ubuntu',
              color: Colors.white,
            ),
          ),
          duration: resultInternet ? Duration(seconds: 3) : Duration(days: 1),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Fechar',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
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
    _connectivitySubscription.cancel();
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
                        utf8.decode(base64Url.decode(value.rawContent ?? '')));

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
                icon: Icon(FontAwesomeIcons.utensils),
                label: Text('AGENDAR REFEIÇÃO'),
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
                    child: Container(),
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
