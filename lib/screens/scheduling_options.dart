import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/models/class_snack.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class SchedulingOptions extends StatefulWidget {
  @override
  _SchedulingOptionsState createState() => _SchedulingOptionsState();
}

class _SchedulingOptionsState extends State<SchedulingOptions> {
  ButtonStyle estiloBotao(Color cor) {
    final ButtonStyle flatButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: cor,
      elevation: 2,
      shadowColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      backgroundColor: cor,
    );
    return flatButtonStyle;
  }

  String botaoSelecionado = "Selecione um botão";
  bool resultInternet = true;

  void _agendarRefeicao(String matricula, String nome, String tipo,
      String instituicao, String periodo, String opcao) {
    if (!resultInternet) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "ATENÇÃO",
              style: TextStyle(color: Colors.red),
            ),
            content: Text("Verifique sua conexão com a internet!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
      return;
    }

    final agendamento = new AgendamentoRefeicao(
      matricula: matricula,
      nome: nome,
      tipo: tipo,
      opcao: opcao,
      periodo: periodo,
      instituicao: instituicao,
    );

    Provider.of<AgendamentosRefeicoes>(context, listen: false)
        .cadastrar(agendamento)
        .then((value) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Retorno da Operação"),
            content: Text(value.substring(0, value.indexOf('.'))),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    });
  }

  String _connection = "";
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

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
      _connection = texto;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription!.cancel();

    super.dispose();
  }

  @override
  void initState() {
    // checkStatus();
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateStatus);
  }

  @override
  Widget build(BuildContext context) {
    String matricula = Provider.of<Login>(context).matricula.toString();
    String nome = Provider.of<Login>(context).usuarioMatricula.toString();
    String periodo = Provider.of<Login>(context).periodoMatricula.toString();
    String tipo = '10';
    String instituicao = Provider.of<Login>(context).idInstituicao.toString();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF130B3B),
        elevation: 0,
        title: Text(
          "AGENDAMENTO PROJETO CRESCER",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: resultInternet
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 23,
                            ),
                            children: [
                              TextSpan(
                                text: 'OLÁ, ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: CustomColors.amarelo,
                                ),
                              ),
                              TextSpan(
                                text: Provider.of<Login>(context)
                                    .usuarioMatricula
                                    .toString(),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.azul,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Selecione apenas uma opção abaixo
                      Center(
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 19,
                              fontFamily: 'Montserrat,',
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'Selecione apenas ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'UMA ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.red[600],
                                ),
                              ),
                              TextSpan(
                                text: 'opção abaixo:',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                        style: estiloBotao(CustomColors.amarelo),
                        onPressed: () {
                          setState(() {
                            _agendarRefeicao(matricula, nome, tipo, instituicao,
                                periodo, '1');
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 65,
                                width: 65,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("images/cafe_novo.png"),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "APENAS CAFÉ",
                                style: TextStyle(
                                  color: CustomColors.azul,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),

                      ElevatedButton(
                        style: estiloBotao(CustomColors.amarelo),
                        onPressed: () {
                          setState(() {
                            _agendarRefeicao(matricula, nome, tipo, instituicao,
                                periodo, '2');
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 65,
                                height: 65,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("images/almoco_novo.png"),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "APENAS ALMOÇO",
                                style: TextStyle(
                                  color: CustomColors.azul,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        style: estiloBotao(CustomColors.amarelo),
                        onPressed: () {
                          setState(() {
                            _agendarRefeicao(matricula, nome, tipo, instituicao,
                                periodo, '3');
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 65,
                                height: 65,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      "images/cafe_almoco_novo.png"),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "CAFÉ E ALMOÇO",
                                style: TextStyle(
                                  color: CustomColors.azul,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          _connection,
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: 14.0),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.grey[300]),
                          strokeWidth: 15,
                        ),
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
