import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projetocrescer/models/class_meal_schedule.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/utils/formater.dart';
import 'package:projetocrescer/widgets/show_case.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

import '../utils/app_route.dart';

class MealPage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING_MEAL";
  @override
  State<MealPage> createState() => _MealPageState();
}

bool _isLoading = true;

class _MealPageState extends State<MealPage> {
  final GlobalKey globalKeyThirteen = GlobalKey();
  final GlobalKey globalKeyFourteen = GlobalKey();

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(MealPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          MealPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  Future<void> loadRefeicoes(BuildContext context) async {
    Provider.of<ListarAgendamentoRefeicao>(context, listen: false)
        .loadRefeicoes()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result)
          ShowCaseWidget.of(context)
              .startShowCase([globalKeyThirteen, globalKeyFourteen]);
      });
    });
    super.initState();
    loadRefeicoes(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> removerAgendamento(String dataRefeicao, String tipoRefeicao,
      String tipoPessoa, String periodo) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
        title: ShowCaseView(
            globalKey: globalKeyThirteen,
            title: 'MEUS DADOS',
            description:
                'Agende facilmente café da manhã e almoço. Remova agendamentos quando necessário. Alimentação balanceada é essencial para o bem-estar e desempenho. Estamos aqui para apoiar seus hábitos saudáveis. Bom apetite!',
            border: CircleBorder(),
            child: Text('AGENDAMENTO')),
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
                        DateTime horaAtual = DateTime.now();
                        if ((horaAtual.hour < 8 ||
                                (horaAtual.hour == 8 &&
                                    horaAtual.minute <= 30)) ||
                            (horaAtual.hour >= 12 && horaAtual.hour < 14)) {
                          Get.toNamed(AppRoute.OPCOES_AGENDAMENTO);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: Text(
                                  'Horário Indisponível',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text(
                                  'Você só pode agendar refeições antes das 8:30 da manhã e 14:00 da tarde.',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 15,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
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
