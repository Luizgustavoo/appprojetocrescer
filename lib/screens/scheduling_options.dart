import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_snack.dart';
import 'package:provider/provider.dart';

class SchedulingOptions extends StatefulWidget {
  @override
  _SchedulingOptionsState createState() => _SchedulingOptionsState();
}

class _SchedulingOptionsState extends State<SchedulingOptions> {
  ButtonStyle estiloBotao(Color cor) {
    final ButtonStyle flatButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: cor,
      elevation: 4,
      shadowColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      backgroundColor: cor,
    );
    return flatButtonStyle;
  }

  bool _isSelectedP1 = true;
  bool _isSelectedP2 = false;

  String matricula = "";
  String nome = "";
  String tipo = "";
  String opcao = "";
  String periodo = "";
  String instituicao = "1";

  String botaoSelecionado = "Selecione um botão";
  bool resultInternet = true;

  void _agendarRefeicao() {
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
    final idPessoa = ModalRoute.of(context)!.settings.arguments as String;

    var jsonTEMP = jsonDecode(utf8.decode(base64Url.decode(idPessoa)));

    matricula = jsonTEMP['matricula'];
    nome = jsonTEMP['nome'];
    periodo = jsonTEMP['periodo'];
    tipo = jsonTEMP['tipo'];

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
                        height: 40,
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
                                  color: Color(0xFFEBAE1F),
                                ),
                              ),
                              TextSpan(
                                text: jsonTEMP['nome'],
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF130B3B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 20),
                        child: Center(
                          child: Text(
                            "ATENÇÃO SELECIONE A INSTITUIÇÃO CORRETA ABAIXO:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Wrap(
                              children: [
                                ChoiceChip(
                                  label: Text(
                                    'PROJETO I',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 50),
                                  selected: _isSelectedP1,
                                  onSelected: (selected) {
                                    setState(() {
                                      _isSelectedP1 = selected;
                                      _isSelectedP2 = !selected;
                                      instituicao = "1";
                                    });
                                  },
                                  selectedColor: Colors.red[700],
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Wrap(
                              children: [
                                ChoiceChip(
                                  label: Text(
                                    'PROJETO II',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 50),
                                  selected: _isSelectedP2,
                                  onSelected: (selected) {
                                    setState(() {
                                      _isSelectedP2 = selected;
                                      _isSelectedP1 = !selected;
                                      instituicao = "2";
                                    });
                                  },
                                  selectedColor: Colors.red[700],
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
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
                                text: 'Selecione apenas, ',
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
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: estiloBotao(Colors.amber),
                        onPressed: () {
                          setState(() {
                            opcao = "1";
                            _agendarRefeicao();
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset("images/cafe_novo.png")),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "APENAS CAFÉ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 38, 255),
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 18.0,
                      ),

                      ElevatedButton(
                        style: estiloBotao(Colors.blue),
                        onPressed: () {
                          setState(() {
                            opcao = "2";
                            _agendarRefeicao();
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset("images/almoco_novo.png")),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "APENAS ALMOÇO",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 18.0,
                      ),
                      ElevatedButton(
                        style: estiloBotao(Color.fromRGBO(76, 175, 80, 1)),
                        onPressed: () {
                          setState(() {
                            opcao = "3";
                            _agendarRefeicao();
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                      "images/cafe_almoco_novo.png")),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "CAFÉ E ALMOÇO",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),

                      //flatButton("Generate QR CODE", GeneratePage()),
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
