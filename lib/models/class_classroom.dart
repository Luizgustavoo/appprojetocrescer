// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:projetocrescer/preferences/store.dart';

class DiaOficina {
  final String idDia;
  final List<String> oficinas;

  DiaOficina({required this.idDia, required this.oficinas});

  factory DiaOficina.fromJson(Map<String, dynamic> json) {
    return DiaOficina(
      idDia: json['idDia'],
      oficinas: List<String>.from(json['oficinas']),
    );
  }
}

class AulasDias with ChangeNotifier {
  List<DiaOficina> _diasOficinas = [];
  List<DiaOficina> get diasOficinas => _diasOficinas;
  final Uri _baseUrl = Uri.parse(
      'http://projetocrescer.ddns.net/sistemaalunos/api/horario/matricula/');

  int get itemsCount {
    return _diasOficinas.length;
  }

  Future<void> loadAulas() async {
    Map<String, dynamic> maps = jsonDecode(await Store.getString('userData'));
    var matricula = maps['matricula_usuario'];
    var _base = Uri.parse('$_baseUrl/$matricula');
    final response = await http.get(_base);

    final jsonData = json.decode(response.body);
    _diasOficinas = List<DiaOficina>.from(
        jsonData.map((data) => DiaOficina.fromJson(data)));

    notifyListeners();
    return Future.value();
  }
}
