import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projetocrescer/utils/constants.dart';

class Penalidade {
  final String? idPenalidade;
  final String? dataPenalidade;
  final String? tipoPenalidade;
  final String? descricaoTipoPenalidade;
  final String? observacao;

  Penalidade({
    this.idPenalidade,
    this.dataPenalidade,
    this.tipoPenalidade,
    this.descricaoTipoPenalidade,
    this.observacao,
  });
}

class Penalidades with ChangeNotifier {
  List<Penalidade> _items = [];
  final String _baseUrl = Constants.URL_LIST_PENALIDADES;

  List<Penalidade> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  int get totalOcorrencias {
    return _items
        .where((penalidade) => int.parse(penalidade.tipoPenalidade!) == 1)
        .toList()
        .length;
  }

  int get totalAdvertencias {
    return _items
        .where((penalidade) => int.parse(penalidade.tipoPenalidade!) == 2)
        .toList()
        .length;
  }

  Future<void> loadPenalidades(String matricula) async {
    var _base = Uri.parse('$_baseUrl/$matricula');
    final response = await http.get(_base);

    final data = json.decode(response.body);
    _items.clear();

    data.forEach((penalidadeData) {
      _items.add(
        Penalidade(
            idPenalidade: penalidadeData['id_penalidade'].toString(),
            dataPenalidade: DateFormat('dd/MM/y').format(
                DateTime.parse(penalidadeData['data_penalidade'].toString())),
            tipoPenalidade: penalidadeData['tipo_penalidade'].toString(),
            descricaoTipoPenalidade:
                penalidadeData['descricao_tipo_penalidade'].toString(),
            observacao: penalidadeData['observacao'].toString()),
      );
    });
    notifyListeners();
    return Future.value();
  }
}
