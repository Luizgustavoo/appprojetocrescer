import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_scheduling.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/widgets/scheduling_tile.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class CoordinationSchedulingPage extends StatefulWidget {
  @override
  _CoordinationSchedulingPageState createState() =>
      _CoordinationSchedulingPageState();
}

class _CoordinationSchedulingPageState
    extends State<CoordinationSchedulingPage> {
  bool _isLoading = true;

  Future<void> loadAgendamentos(BuildContext context) async {
    await Provider.of<AgendamentosAtendimentos>(context, listen: false)
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
    final agendamentos = agendamentosData.itemsCoordenacao;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AG. COORDENAÇÃO',
        ),
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
