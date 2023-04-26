import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projetocrescer/utils/constants.dart';

class Frequencia {
  final String nomePessoa;
  final String idMatricula;
  final String dataFrequencia;
  final String justificado;
  final String justificativa;
  final String tipoFalta;
  final String descricaoTipoFalta;

  Frequencia({
    this.descricaoTipoFalta,
    this.nomePessoa,
    this.idMatricula,
    this.dataFrequencia,
    this.justificado,
    this.justificativa,
    this.tipoFalta,
  });
}

class Frequencias with ChangeNotifier {
  List<Frequencia> _items = [];
  final String _baseUrl = Constants.URL_LIST_FREQUENCIA;

  List<Frequencia> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  int get totalJustificada {
    return _items
        .where((frequencia) => frequencia.justificado == 'SIM')
        .toList()
        .length;
  }

  int get totalNaoJustificada {
    return _items
        .where((frequencia) => frequencia.justificado == 'nao')
        .toList()
        .length;
  }

  Future<void> loadFrequencias(String matricula) async {
    var _base = Uri.parse('$_baseUrl/$matricula');
    final response = await http.get(_base);

    final data = json.decode(response.body);
    _items.clear();

    data.forEach((dados) {
      _items.add(
        Frequencia(
            nomePessoa: dados['nome_pessoa'].toString(),
            idMatricula: dados['id_matricula'].toString(),
            dataFrequencia: DateFormat('dd/MM/y')
                .format(DateTime.parse(dados['data_frequencia'].toString())),
            justificado: dados['justificado'].toString(),
            justificativa: dados['justificativa'].toString(),
            descricaoTipoFalta: dados['descricao_tipo_falta'].toString(),
            tipoFalta: dados['tipo_falta'].toString()),
      );
    });
    notifyListeners();
    return Future.value();
  }
}
