// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:projetocrescer/preferences/store.dart';
import 'package:projetocrescer/utils/constants.dart';

class Usuario {
  final String? matriculaUsuario;
  final String? nomeUsuario;
  final String? emailUsuario;
  final String? foto;
  final String? serieMatricula;

  Usuario({
    // ignore: non_constant_identifier_names
    this.matriculaUsuario,
    this.nomeUsuario,
    this.emailUsuario,
    this.foto,
    this.serieMatricula,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matricula_usuario': matriculaUsuario,
      'nome_usuario': nomeUsuario,
      'email_usuario': emailUsuario,
      'foto': foto,
      'serie_matricula': serieMatricula,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      matriculaUsuario: map['matricula_usuario'] != null
          ? map['matricula_usuario'] as String
          : null,
      nomeUsuario:
          map['nome_usuario'] != null ? map['nome_usuario'] as String : null,
      emailUsuario:
          map['email_usuario'] != null ? map['email_usuario'] as String : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
      serieMatricula: map['serie_matricula'] != null
          ? map['serie_matricula'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(matriculaUsuario: $matriculaUsuario, nomeUsuario: $nomeUsuario, emailUsuario: $emailUsuario, foto: $foto, serieMatricula: $serieMatricula)';
  }
}

class Login with ChangeNotifier {
  final Uri _baseUrl = Uri.parse(Constants.URL_LIST_USUARIOS);
  List<Usuario> _items = [];

  List<Usuario> get items => [..._items];

  String? _matricula;
  String? _usuarioMatricula;
  String? _foto;
  String? _serieMatricula;

  int get itemsCount {
    return _items.length;
  }

  // ignore: missing_return
  String? get serie {
    return _serieMatricula;
  }

  // ignore: missing_return
  String? get foto {
    return _foto;
  }

  // ignore: missing_return
  String? get matricula {
    return _matricula;
  }

  // ignore: missing_return
  String? get usuarioMatricula {
    return _usuarioMatricula;
  }

  bool get isAuth {
    return matricula != null;
  }

  Future<void> get logout async {
    _items.clear();
    _matricula = null;
    _usuarioMatricula = null;
    _foto = null;
    _serieMatricula = null;
    Store.remove('userData');
    notifyListeners();
  }

  Future<void> tryAutologin() async {
    if (isAuth) {
      return Future.value();
    }
    final userData = await Store.getMap('userData');

    if (userData == null) {
      return Future.value();
    } else {
      _matricula = userData["matricula_usuario"].toString();
      _usuarioMatricula = userData["nome_usuario"].toString();
      _foto = userData["foto"].toString();
      _serieMatricula = userData["serie_matricula"].toString();

      notifyListeners();
      return Future.value();
    }
  }

  Future<String> signin(String email, String senha, int tipoLogin) async {
    String retorno = "fail";
    print(tipoLogin);

    final response = await http.post(
      _baseUrl,
      body: {
        "email": email,
        "senha": senha,
      },
    );

    if (response.body.contains('error')) {
      retorno = json.decode(response.body)['error'];
    } else {
      if (response.body.isNotEmpty) {
        // print(response.body);

        _items.clear();
        var data = json.decode(response.body);

        if (data != null) {
          //print(data);
          data.forEach((usuarioData) {
            _items.add(
              Usuario(
                matriculaUsuario: usuarioData['matricula_usuario'].toString(),
                nomeUsuario: usuarioData['nome_usuario'].toString(),
                emailUsuario: usuarioData['email_usuario'].toString(),
                foto: usuarioData['foto'].toString(),
                serieMatricula: usuarioData['serie_matricula'].toString(),
              ),
            );

            _matricula = usuarioData['matricula_usuario'].toString();
            _usuarioMatricula = usuarioData['nome_usuario'].toString();
            _foto = usuarioData['foto'].toString();
            _serieMatricula = usuarioData['serie_matricula'].toString();

            Store.saveMap('userData', {
              "matricula_usuario": usuarioData['matricula_usuario'].toString(),
              "nome_usuario": usuarioData['nome_usuario'].toString(),
              "email_usuario": usuarioData['email_usuario'].toString(),
              "foto": usuarioData['foto'].toString(),
              "serie_matricula": usuarioData['serie_matricula'].toString(),
            });
          });
          retorno = 'success';
        } else {
          retorno = 'fail';
        }
      }
    }
    notifyListeners();
    return Future.value(retorno);
  }
}
