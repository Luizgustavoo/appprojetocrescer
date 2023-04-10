import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/app_route.dart';
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
      appBar: PreferredSize(
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          title: Text(
            'AGENDAMENTOS COORDENAÇÃO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).textScaleFactor * 18,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(70),
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
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoute.AGENDAR_COORDENACAO);
        },
        label: Text("Novo"),
        icon: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class AgendamentosItem extends StatefulWidget {
  final AgendamentoAtendimento agendamento;

  AgendamentosItem(this.agendamento);

  @override
  _AgendamentosItemState createState() => _AgendamentosItemState();
}

class _AgendamentosItemState extends State<AgendamentosItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    String imagem = 'images/negativo.png';
    if (widget.agendamento.statusAgendamento
        .toString()
        .toLowerCase()
        .contains("confirmado")) {
      imagem = 'images/confirmado.png';
    }

    if (widget.agendamento.statusAgendamento
        .toString()
        .toLowerCase()
        .contains("aguardando")) {
      imagem = 'images/aguardando.png';
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                title: Text(
                  widget.agendamento.statusAgendamento.replaceAll('_', ' '),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).textScaleFactor * 16),
                ),
                subtitle: Text(
                  widget.agendamento.dataAgendamento +
                      " - " +
                      widget.agendamento.horaAgendamento,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                leading: Image.asset(imagem),
                trailing: Icon(
                  Icons.arrow_drop_down,
                )),
            if (_expanded)
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListView(
                  children: [
                    Text(
                      widget.agendamento.motivoAgendamento,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
