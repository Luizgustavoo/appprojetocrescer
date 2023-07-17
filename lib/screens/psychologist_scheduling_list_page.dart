import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_scheduling.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/widgets/scheduling_tile.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class PsychologistSchedulingPage extends StatefulWidget {
  @override
  _PsychologistSchedulingPageState createState() =>
      _PsychologistSchedulingPageState();
}

class _PsychologistSchedulingPageState
    extends State<PsychologistSchedulingPage> {
  bool _isLoading = true;

  Future<void> loadAgendamentos(BuildContext context) {
    return Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .loadAgendamentos(Provider.of<Login>(context, listen: false).matricula!)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadAgendamentos(context);
  }

  Widget build(BuildContext context) {
    final agendamentosData = Provider.of<AgendamentosAtendimentos>(context);
    final agendamentos = agendamentosData.itemsPsicologo;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AG. PSICÓLOGO',
        ),
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
                        : ListView.builder(
                            itemCount: agendamentosData.itemsCountPsicologo,
                            itemBuilder: (ctx, i) {
                              return SchedulingItem(agendamentos[i]);
                            },
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
        label: Text(
          "NOVO",
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
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
