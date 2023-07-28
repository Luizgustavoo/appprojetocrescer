import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projetocrescer/models/class_meal_schedule.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/utils/formater.dart';
import 'package:provider/provider.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

import '../utils/app_route.dart';

class MealPage extends StatefulWidget {
  @override
  State<MealPage> createState() => _MealPageState();
}

String qrCodeResult = "Aguardando...";
String codeInvalido = "";
bool resultInternet = false;
bool _isLoading = true;
StreamSubscription<ConnectivityResult>? _connectivitySubscription;

class _MealPageState extends State<MealPage> {
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
    Provider.of<ListarAgendamentoRefeicao>(context, listen: false)
        .loadRefeicoes()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription?.cancel();
  }

  Future<void> agendar() async {
    await BarcodeScanner.scan().then((value) {
      var jsonTEMP =
          jsonDecode(utf8.decode(base64Url.decode(value.rawContent)));

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
        Navigator.of(context).pushNamed(AppRoute.OPCOES_AGENDAMENTO,
            arguments: value.rawContent);
      }
    });
  }

  Future<void> removerAgendamento(String dataRefeicao, String tipoRefeicao,
      String tipoPessoa, String periodo) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('REMOVER AGENDAMENTO'),
            content: Text('Deseja realmente remover esse agendamento?'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    Provider.of<ListarAgendamentoRefeicao>(context,
                            listen: false)
                        .loadRefeicoes();
                    Get.back();
                  });
                },
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Provider.of<ListarAgendamentoRefeicao>(context, listen: false)
                      .removeRefeicoes(
                          dataRefeicao, tipoRefeicao, tipoPessoa, periodo)
                      .then((value) {
                    if (value == true) {
                      setState(() {
                        Provider.of<ListarAgendamentoRefeicao>(context,
                                listen: false)
                            .loadRefeicoes();
                        Get.back();
                      });
                    }
                    print(value);
                  });
                },
                child: const Text(
                  'CONFIRMAR',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AGENDAMENTO'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        agendar();
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
                Expanded(child: Consumer<ListarAgendamentoRefeicao>(
                  builder: (ctx, agendamento, _) {
                    final refeicoes = agendamento.items;
                    return ListView.builder(
                      itemCount: 30,
                      itemBuilder: (ctx, i) {
                        final refeicao = refeicoes[i];
                        List<String> rf =
                            refeicao.tipoStatus.toString().split(',');
                        DateTime dataAtual = DateTime.now();
                        var dataFormatada = DateTime.parse(
                            refeicao.dataRefeicao! + " 18:30:00");
                        return AnimationConfiguration.staggeredList(
                          position: i,
                          duration: Duration(milliseconds: 50),
                          child: ScaleAnimation(
                              duration: Duration(milliseconds: 150),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Card(
                                      elevation: 2,
                                      child: ExpansionTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        title: Text(
                                          DateFormat('dd/MM/y').format(
                                              DateTime.parse(
                                                  refeicao.dataRefeicao!)),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 20,
                                          ),
                                        ),
                                        children: [
                                          Table(
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            children: [
                                              for (int i = 0;
                                                  i < rf.length;
                                                  i++) ...[
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        rf[i].toString().split(
                                                                    '=')[0] ==
                                                                '1'
                                                            ? 'CAFÉ'
                                                            : 'ALMOÇO',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: rf[i].toString().split(
                                                                      '=')[1] ==
                                                                  'feita'
                                                              ? Colors.green
                                                                  .shade700
                                                              : Colors
                                                                  .red.shade700,
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    rf[i].toString().split(
                                                                    '=')[1] ==
                                                                'agendada' &&
                                                            Formater.comparaData(
                                                                dataFormatada,
                                                                dataAtual)
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  removerAgendamento(
                                                                      DateFormat(
                                                                              'y-MM-dd')
                                                                          .format(
                                                                              dataFormatada),
                                                                      rf[i].toString().split(
                                                                              '=')[
                                                                          0],
                                                                      '10',
                                                                      rf[i]
                                                                          .toString()
                                                                          .split(
                                                                              '=')[2]);
                                                                },
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red
                                                                      .shade700,
                                                                )),
                                                          )
                                                        : SizedBox.shrink()
                                                  ],
                                                )
                                              ]
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    );
                  },
                )),
              ],
            ),
    );
  }
}
