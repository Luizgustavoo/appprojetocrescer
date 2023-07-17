import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projetocrescer/utils/constants.dart';

class Pendencia {
  final String? idPendencia;
  final String? dataPendencia;
  final String? descricaoTipoPendencia;
  final String? observacao;
  final String? statusPendencia;

  Pendencia({
    this.idPendencia,
    this.dataPendencia,
    this.descricaoTipoPendencia,
    this.observacao,
    this.statusPendencia,
  });
}

class Pendencias with ChangeNotifier {
  List<Pendencia> _items = [];
  final String _baseUrl = Constants.URL_LIST_PENDENCIAS;

  List<Pendencia> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

//  int get totalOcorrencias {
//     return _items.where((penalidade) => int.parse(penalidade.tipo_penalidade) == 1).toList().length;
//   }

//  int get totalAdvertencias {
//     return _items.where((penalidade) => int.parse(penalidade.tipo_penalidade) == 2).toList().length;
//   }

  Future<void> loadPendencias(String matricula) async {
    var _base = Uri.parse('$_baseUrl/$matricula');
    final response = await http.get(_base);

    final data = json.decode(response.body);
    _items.clear();

    data.forEach((dados) {
      _items.add(
        Pendencia(
            idPendencia: dados['id_pendencia'].toString(),
            dataPendencia: DateFormat('dd/MM/y')
                .format(DateTime.parse(dados['data_pendencia'].toString())),
            descricaoTipoPendencia:
                dados['descricao_tipo_pendencia'].toString(),
            observacao: dados['observacao'].toString(),
            statusPendencia: dados['status_pendencia'].toString()),
      );
    });
    notifyListeners();
    return Future.value();
  }
}
