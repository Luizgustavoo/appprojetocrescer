// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetocrescer/preferences/store.dart';
import 'package:http/http.dart' as http;

class Refeicao {
  final String? dataRefeicao;
  final String? tipoStatus;
  Refeicao({
    this.dataRefeicao,
    this.tipoStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data_refeicao': dataRefeicao,
      'tipo_status': tipoStatus,
    };
  }

  factory Refeicao.fromMap(Map<String, dynamic> map) {
    return Refeicao(
      dataRefeicao:
          map['data_refeicao'] != null ? map['data_refeicao'] as String : null,
      tipoStatus:
          map['tipo_status'] != null ? map['tipo_status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Refeicao.fromJson(String source) =>
      Refeicao.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ListarAgendamentoRefeicao with ChangeNotifier {
  List<Refeicao> _items = [];
  final Uri _baseUrl =
      Uri.parse('http://projetocrescer.ddns.net/sistemaalunos/api');

  List<Refeicao> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadRefeicoes() async {
    Map<String, dynamic> maps = jsonDecode(await Store.getString('userData'));
    var matricula = maps['matricula_usuario'];
    var _base = Uri.parse('$_baseUrl/refeicoes/matricula/$matricula');
    final response = await http.get(_base);
    final data = json.decode(response.body);
    _items.clear();
    data.forEach((dados) {
      _items.add(Refeicao.fromMap(dados));
    });
    notifyListeners();
    return Future.value();
  }

  Future<bool> removeRefeicoes(String dataRefeicao, String tipoRefeicao,
      String tipoPessoa, String periodo) async {
    Map<String, dynamic> maps = jsonDecode(await Store.getString('userData'));
    var matricula = maps['matricula_usuario'];
    var _base = Uri.parse('$_baseUrl/removeagendamento');
    var response = await http.post(_base, body: {
      "matricula": matricula,
      "data_refeicao": dataRefeicao,
      "tipo_refeicao": tipoRefeicao,
      "tipo_pessoa": tipoPessoa,
      "periodo": periodo,
    });

    final data = json.decode(response.body);
    print(data);
    if (data != null) {
      notifyListeners();
      return Future.value(true);
    }
    notifyListeners();
    return Future.value(false);
  }
}
