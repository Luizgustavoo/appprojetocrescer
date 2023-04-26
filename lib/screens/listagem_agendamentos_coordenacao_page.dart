import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/widgets/agendamento_item_tile.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class ListagemAgendamentoCoordenacaoPage extends StatefulWidget {
  @override
  _ListagemAgendamentoCoordenacaoPageState createState() =>
      _ListagemAgendamentoCoordenacaoPageState();
}

class _ListagemAgendamentoCoordenacaoPageState
    extends State<ListagemAgendamentoCoordenacaoPage> {
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
              color: CustomColors.amarelo,
              onRefresh: () => loadAgendamentos(context),
              child: Column(
                children: [
                  Expanded(
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
