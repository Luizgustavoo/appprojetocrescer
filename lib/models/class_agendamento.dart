import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projetocrescer/utils/constants.dart';

class AgendamentoAtendimento {
  final String idAgendamento;
  final String dataAgendamento;
  final String horaAgendamento;
  final String matricula;
  final String nomePessoa;
  final String dataCadastro;
  final String setorAgendamento;
  final String statusAgendamento;
  final String motivoAgendamento;

  AgendamentoAtendimento({
    this.idAgendamento,
    this.dataAgendamento,
    this.horaAgendamento,
    this.matricula,
    this.nomePessoa,
    this.dataCadastro,
    this.setorAgendamento,
    this.statusAgendamento,
    this.motivoAgendamento,
  });
}

class AgendamentosAtendimentos with ChangeNotifier {
  final Uri _baseUrl = Uri.parse(Constants.URL_AGENDAMENTO);
  List<AgendamentoAtendimento> _items = [];

  List<AgendamentoAtendimento> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  int get itemsCountCoordenacaoConfirmado {
    return _items
        .where((coordenacao) =>
            coordenacao.setorAgendamento.toLowerCase() == 'coordenacao' &&
            (coordenacao.statusAgendamento
                .toLowerCase()
                .contains('confirmado')))
        .toList()
        .length;
  }

  int get itemsCountPsicologoConfirmado {
    return _items
        .where((psicologo) =>
            psicologo.setorAgendamento.toLowerCase() == 'psicologo' &&
            (psicologo.statusAgendamento.toLowerCase().contains('confirmado')))
        .toList()
        .length;
  }

  int get itemsCountCoordenacao {
    return _items
        .where((coordenacao) =>
            coordenacao.setorAgendamento.toLowerCase() == 'coordenacao')
        .toList()
        .length;
  }

  int get itemsCountPsicologo {
    return _items
        .where((coordenacao) =>
            coordenacao.setorAgendamento.toLowerCase() == 'psicologo')
        .toList()
        .length;
  }

  List<AgendamentoAtendimento> get itemsCoordenacao {
    return _items
        .where((coordenacao) =>
            coordenacao.setorAgendamento.toLowerCase() == 'coordenacao')
        .toList();
  }

  List<AgendamentoAtendimento> get itemsPsicologo {
    return _items
        .where((psicologo) =>
            psicologo.setorAgendamento.toLowerCase() == 'psicologo')
        .toList();
  }

  Future<String> cadastrar(AgendamentoAtendimento agendamento) async {
    String retorno = "fail";

    final response = await http.post(
      _baseUrl,
      body: {
        "data_agendamento": agendamento.dataAgendamento,
        "hora_agendamento": agendamento.horaAgendamento,
        "matricula": agendamento.matricula,
        "nome_pessoa": agendamento.nomePessoa,
        "setor_agendamento": agendamento.setorAgendamento,
        "status_agendamento": agendamento.statusAgendamento,
        "motivo_agendamento": agendamento.motivoAgendamento,
      },
    );

    if (response.body.contains('return')) {
      retorno = json.decode(response.body)['return'];
    }

    print(retorno);

    notifyListeners();
    return Future.value(retorno);
  }

  Future<void> loadAgendamentos(String matricula) async {
    final _baseUrl = Constants.URL_LIST_AGENDAMENTOS;
    final Uri _base = Uri.http(_baseUrl, '$matricula');
    final response = await http.get(_base);

    final data = json.decode(response.body);
    _items.clear();

    if (data != null) {
      data.forEach((dados) {
        _items.add(
          AgendamentoAtendimento(
            idAgendamento: dados['id_agendamento'].toString(),
            dataAgendamento: DateFormat('dd/MM/y')
                .format(DateTime.parse(dados['data_agendamento'].toString())),
            horaAgendamento: dados['hora_agendamento'].toString(),
            matricula: dados['matricula'].toString(),
            nomePessoa: dados['nome_pessoa'].toString(),
            dataCadastro: DateFormat('dd/MM/y')
                .format(DateTime.parse(dados['data_cadastro'].toString())),
            setorAgendamento: dados['setor_agendamento'].toString(),
            statusAgendamento: dados['status_agendamento'].toString(),
            motivoAgendamento: dados['motivo_agendamento'].toString(),
          ),
        );
      });
    }

    notifyListeners();
    return Future.value();
  }
}
