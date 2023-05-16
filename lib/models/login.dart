import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetocrescer/preferences/store.dart';
import 'package:projetocrescer/utils/constants.dart';

class Usuario {
  final String matriculaUsuario;
  final String nomeUsuario;
  final String emailUsuario;
  final String foto;
  // ignore: non_constant_identifier_names
  final String serie_matricula;

  Usuario({
    // ignore: non_constant_identifier_names
    this.serie_matricula,
    this.foto,
    this.matriculaUsuario,
    this.nomeUsuario,
    this.emailUsuario,
  });
}

class Login with ChangeNotifier {
  final Uri _baseUrl = Uri.parse(Constants.URL_LIST_USUARIOS);
  List<Usuario> _items = [];

  List<Usuario> get items => [..._items];

  String _matricula;
  String _usuarioMatricula;
  String _foto;
  // ignore: non_constant_identifier_names
  String _serie_matricula;

  int get itemsCount {
    return _items.length;
  }

  // ignore: missing_return
  String get serie {
    if (_serie_matricula != null) {
      return _serie_matricula;
    }
  }

  // ignore: missing_return
  String get foto {
    if (_foto != null) {
      return _foto;
    }
  }

  // ignore: missing_return
  String get matricula {
    if (_matricula != null) {
      return _matricula;
    }
  }

  // ignore: missing_return
  String get usuarioMatricula {
    if (_usuarioMatricula != null) {
      return _usuarioMatricula;
    }
  }

  bool get isAuth {
    return usuarioMatricula != null && matricula != null;
  }

  Future<void> get logout async {
    _items.clear();
    _matricula = null;
    _usuarioMatricula = null;
    _foto = null;
    _serie_matricula = null;
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
      _serie_matricula = userData["serie_matricula"].toString();

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
                serie_matricula: usuarioData['serie_matricula'].toString(),
              ),
            );

            _matricula = usuarioData['matricula_usuario'].toString();
            _usuarioMatricula = usuarioData['nome_usuario'].toString();
            _foto = usuarioData['foto'].toString();
            _serie_matricula = usuarioData['serie_matricula'].toString();

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
