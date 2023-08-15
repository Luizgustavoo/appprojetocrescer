import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_scheduling.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/widgets/scheduling_tile.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/show_case.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class CoordinationSchedulingPage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING_COORDINATION";
  @override
  _CoordinationSchedulingPageState createState() =>
      _CoordinationSchedulingPageState();
}

class _CoordinationSchedulingPageState
    extends State<CoordinationSchedulingPage> {
  bool _isLoading = true;
  final GlobalKey globalKeyEight = GlobalKey();
  final GlobalKey globalKeyNine = GlobalKey();

  Future<void> loadAgendamentos(BuildContext context) async {
    await Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .loadAgendamentos(Provider.of<Login>(context, listen: false).matricula!)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences.getBool(
            CoordinationSchedulingPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          CoordinationSchedulingPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result)
          ShowCaseWidget.of(context)
              .startShowCase([globalKeyEight, globalKeyNine]);
      });
    });
    super.initState();
    loadAgendamentos(context);
  }

  Widget build(BuildContext context) {
    final agendamentosData = Provider.of<AgendamentosAtendimentos>(context);
    final agendamentos = agendamentosData.itemsCoordenacao;

    return Scaffold(
      appBar: AppBar(
        title: ShowCaseView(
            globalKey: globalKeyEight,
            title: 'AG. COORDENAÇÃO',
            description:
                'Agende consultas com os psicólogos da escola de forma simples e acolhedora. Nossa equipe está pronta para apoiar o desenvolvimento emocional e comportamental dos alunos. Garantimos confidencialidade e suporte contínuo. Sua opinião é valiosa para nós. Entre em contato para mais informações. Estamos aqui para ajudar!',
            border: CircleBorder(),
            child: Text('AG. COORDENAÇÃO')),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              color: CustomColors.amarelo,
              onRefresh: () => loadAgendamentos(context),
              child: agendamentosData.itemsCountCoordenacao <= 0
                  ? Center(
                      child: Text(
                        'Nenhum agendamento encontrado!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: agendamentosData.itemsCountCoordenacao,
                      itemBuilder: (ctx, i) {
                        return SchedulingItem(agendamentos[i]);
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoute.AGENDAR_COORDENACAO);
        },
        label: ShowCaseView(
          globalKey: globalKeyNine,
          title: 'NOVO AGENDAMENTO',
          description:
              'Clique aqui para adicionar um novo agendamento com um de nossos psicólogos da instituição.',
          border: CircleBorder(),
          child: Text(
            "NOVO",
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        icon: Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        backgroundColor: CustomColors.azul,
      ),
    );
  }
}
