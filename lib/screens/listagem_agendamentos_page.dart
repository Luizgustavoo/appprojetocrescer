import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/widgets/agendamento_item_tile.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class ListagemAgendamentoPage extends StatefulWidget {
  @override
  _ListagemAgendamentoPageState createState() =>
      _ListagemAgendamentoPageState();
}

class _ListagemAgendamentoPageState extends State<ListagemAgendamentoPage> {
  bool _isLoading = true;

  Future<void> loadAgendamentos(BuildContext context) {
    return Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .loadAgendamentos(Provider.of<Login>(context, listen: false).matricula)
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
              onRefresh: () => loadAgendamentos(context),
              child: Column(
                children: [
                  Expanded(
                    child: agendamentosData.itemsCountCoordenacao <= 0
                        ? Center(
                            child: Text('Nenhum agendamento encontrado!'),
                          )
                        : ListView.builder(
                            itemCount: agendamentosData.itemsCountCoordenacao,
                            itemBuilder: (ctx, i) {
                              return AgendamentosItem(agendamentos[i]);
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
          Navigator.of(context).pushNamed(AppRoute.AGENDAR_COORDENACAO);
        },
        label: Text(
          "NOVO",
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: Icon(
          Icons.add_rounded,
        ),
        backgroundColor: CustomColors.azul,
      ),
    );
  }
}
