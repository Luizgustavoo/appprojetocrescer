// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:projetocrescer/preferences/store.dart';

class Dias {
  List<String>? segunda;
  List<String>? terca;
  List<String>? quarta;
  List<String>? quinta;
  List<String>? sexta;
  Dias({
    this.segunda,
    this.terca,
    this.quarta,
    this.quinta,
    this.sexta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'segunda': segunda,
      'terca': terca,
      'quarta': quarta,
      'quinta': quinta,
      'sexta': sexta,
    };
  }

  factory Dias.fromMap(Map<String, dynamic> map) {
    return Dias(
      segunda: map['segunda'] != null
          ? List<String>.from(map['segunda'] as List<String>)
          : null,
      terca: map['terca'] != null
          ? List<String>.from(map['terca'] as List<String>)
          : null,
      quarta: map['quarta'] != null
          ? List<String>.from(map['quarta'] as List<String>)
          : null,
      quinta: map['quinta'] != null
          ? List<String>.from(map['quinta'] as List<String>)
          : null,
      sexta: map['sexta'] != null
          ? List<String>.from(map['sexta'] as List<String>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dias.fromJson(String source) =>
      Dias.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Dias(segunda: $segunda, terca: $terca, quarta: $quarta, quinta: $quinta, sexta: $sexta)';
  }
}

class AulasDias with ChangeNotifier {
  List<Dias> _items = [];
  final Uri _baseUrl = Uri.parse(
      'http://projetocrescer.ddns.net/sistemaalunos/api/horario/matricula/');

  List<Dias> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadAulas() async {
    Map<String, dynamic> maps = jsonDecode(await Store.getString('userData'));
    var matricula = maps['matricula_usuario'];
    var _base = Uri.parse('$_baseUrl/$matricula');
    final response = await http.get(_base);
    final data = json.decode(response.body);
    // print(data['segunda'][0]);
    // print(data['segunda'][1]);
    // print(data['segunda'][2]);
    // print('-------------');
    // print(data['terca'][0]);
    // print(data['terca'][1]);
    // print(data['terca'][2]);
    // print('-------------');
    // print(data['quarta'][0]);
    // print(data['quarta'][1]);
    // print(data['quarta'][2]);
    // print('-------------');
    // print(data['quinta'][0]);
    // print(data['quinta'][1]);
    // print(data['quinta'][2]);
    // print('-------------');
    // print(data['sexta'][0]);
    // print(data['sexta'][1]);
    // print(data['sexta'][2]);
    print('-------------');
    print(data);
    data['segunda'].forEach((dados) {
      print(dados);
    });
    // data.map((item) {
    //   final Dias dias = Dias.fromMap(item);
    //   _items.add(dias);
    // }).toList();

    notifyListeners();
    return Future.value();
  }
}
