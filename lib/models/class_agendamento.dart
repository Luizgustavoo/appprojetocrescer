import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projetocrescer/utils/constants.dart';
import 'dart:async';

class AgendamentoAtendimento {
  final String? idAgendamento;
  final String? nomeResponsavel;
  final String? motivoAgendamento;
  final String? dataAgendamento;
  final String? horaAgendamento;
  final String? statusAgendamento;
  final String? idMatricula;
  final String? dataSolicitacao;
  final String? setorAgendamento;

  AgendamentoAtendimento({
    this.nomeResponsavel,
    this.idMatricula,
    this.dataSolicitacao,
    this.idAgendamento,
    this.dataAgendamento,
    this.horaAgendamento,
    this.setorAgendamento,
    this.statusAgendamento,
    this.motivoAgendamento,
  });
}

class AgendamentosAtendimentos with ChangeNotifier {
  var _baseUrl = Uri.parse(Constants.URL_AGENDAMENTO);
  List<AgendamentoAtendimento> _items = [];

  List<AgendamentoAtendimento> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  int get itemsCountCoordenacaoConfirmado {
    return _items
        .where((coordenacao) =>
            coordenacao.setorAgendamento!.toLowerCase() == 'coordenacao' &&
            (coordenacao.statusAgendamento!
                .toLowerCase()
                .contains('confirmado')))
        .toList()
        .length;
  }

  int get itemsCountPsicologoConfirmado {
    return _items
        .where((psicologo) =>
            psicologo.setorAgendamento!.toLowerCase() == 'psicologo' &&
            (psicologo.statusAgendamento!.toLowerCase().contains('confirmado')))
        .toList()
        .length;
  }

  int get itemsCountCoordenacao {
    return _items
        .where((coordenacao) =>
            coordenacao.setorAgendamento!.toLowerCase() == 'coordenacao')
        .toList()
        .length;
  }

  int get itemsCountPsicologo {
    return _items
        .where((coordenacao) =>
            coordenacao.setorAgendamento!.toLowerCase() == 'psicologo')
        .toList()
        .length;
  }

  List<AgendamentoAtendimento> get itemsCoordenacao {
    return _items
        .where((coordenacao) =>
            coordenacao.setorAgendamento!.toLowerCase() == 'coordenacao')
        .toList();
  }

  List<AgendamentoAtendimento> get itemsPsicologo {
    return _items
        .where((psicologo) =>
            psicologo.setorAgendamento!.toLowerCase() == 'psicologo')
        .toList();
  }

  Future<String> cadastrar(AgendamentoAtendimento agendamento) async {
    String retorno = "fail";

    final response = await http.post(
      _baseUrl,
      body: {
        "id_matricula": agendamento.idMatricula,
        "nome_responsavel": agendamento.nomeResponsavel,
        "setor_agendamento": agendamento.setorAgendamento,
        "status_agendamento": agendamento.statusAgendamento,
        "data_agendamento": agendamento.dataAgendamento,
        "hora_agendamento": agendamento.horaAgendamento,
        "motivo_agendamento": agendamento.motivoAgendamento,
      },
    );

    if (response.body.contains('return')) {
      retorno = json.decode(response.body)['return'];
    }

    print(response.body);

    notifyListeners();
    return Future.value(retorno);
  }

  Future<void> loadAgendamentos(String matricula) async {
    final String _baseUrl = Constants.URL_LIST_AGENDAMENTOS;
    var _base = Uri.parse('$_baseUrl/$matricula');
    final response = await http.get(_base);

    final data = json.decode(response.body);
    _items.clear();

    if (data != null) {
      data.forEach((dados) {
        _items.add(
          AgendamentoAtendimento(
            idAgendamento: dados['id_agendamento'].toString(),
            nomeResponsavel: dados['nome_responsavel'].toString(),
            motivoAgendamento: dados['motivo_agendamento'].toString(),
            dataAgendamento: DateFormat('dd/MM/y')
                .format(DateTime.parse(dados['data_agendamento'].toString())),
            horaAgendamento: dados['hora_agendamento'].toString(),
            statusAgendamento: dados['status_agendamento'].toString(),
            idMatricula: dados['id_matricula'].toString(),
            dataSolicitacao: DateFormat('dd/MM/y')
                .format(DateTime.parse(dados['data_solicitacao'].toString())),
            setorAgendamento: dados['setor_agendamento'].toString(),
          ),
        );
      });
    }

    notifyListeners();
    return Future.value();
  }
}
