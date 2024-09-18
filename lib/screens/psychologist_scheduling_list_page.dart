import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_scheduling.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/routes/app_route.dart';
import 'package:projetocrescer/widgets/scheduling_tile.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/show_case.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class PsychologistSchedulingPage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING_PSYCHOLOGIST";
  @override
  _PsychologistSchedulingPageState createState() =>
      _PsychologistSchedulingPageState();
}

class _PsychologistSchedulingPageState
    extends State<PsychologistSchedulingPage> {
  bool _isLoading = true;
  final GlobalKey globalKeyFour = GlobalKey();
  final GlobalKey globalKeyFive = GlobalKey();

  Future<void> loadAgendamentos(BuildContext context) async {
    final matricula = Provider.of<Login>(context, listen: false).matricula;
    if (matricula != null) {
      await Provider.of<AgendamentosAtendimentos>(context, listen: false)
          .loadAgendamentos(matricula);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences.getBool(
            PsychologistSchedulingPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          PsychologistSchedulingPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result)
          ShowCaseWidget.of(context)
              .startShowCase([globalKeyFour, globalKeyFive]);
      });
    });
    super.initState();
    loadAgendamentos(context);
  }

  Widget _buildSchedulingItem(BuildContext context, int index) {
    final agendamentosData = Provider.of<AgendamentosAtendimentos>(context);
    final agendamentos = agendamentosData.itemsPsicologo;
    return SchedulingItem(agendamentos[index]);
  }

  Widget _buildEmptySchedulingList() {
    return Center(
      child: Text(
        'Nenhum agendamento encontrado!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    final agendamentosData = Provider.of<AgendamentosAtendimentos>(context);

    return Scaffold(
      appBar: AppBar(
        title: ShowCaseView(
            globalKey: globalKeyFour,
            title: 'AG. PSICÓLOGO',
            description:
                'Agende consultas com os psicólogos da escola de forma simples e acolhedora. Nossa equipe está pronta para apoiar o desenvolvimento emocional e comportamental dos alunos. Garantimos confidencialidade e suporte contínuo. Sua opinião é valiosa para nós. Entre em contato para mais informações. Estamos aqui para ajudar!',
            border: CircleBorder(),
            child: Text('AG. PSICÓLOGO')),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              color: CustomColors.amarelo,
              onRefresh: () => loadAgendamentos(context),
              child: Column(
                children: [
                  Expanded(
                    child: agendamentosData.itemsCountPsicologo <= 0
                        ? _buildEmptySchedulingList()
                        : ListView.builder(
                            itemCount: agendamentosData.itemsCountPsicologo,
                            itemBuilder: (ctx, i) =>
                                _buildSchedulingItem(context, i),
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoute.AGENDAR_PSICOLOGO);
        },
        label: ShowCaseView(
          globalKey: globalKeyFive,
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
