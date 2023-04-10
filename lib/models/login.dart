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

  Usuario({
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

  int get itemsCount {
    return _items.length;
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

      notifyListeners();
      return Future.value();
    }
  }

  Future<String> signin(String email, String senha) async {
    String retorno = "fail";

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
              ),
            );

            _matricula = usuarioData['matricula_usuario'].toString();
            _usuarioMatricula = usuarioData['nome_usuario'].toString();

            Store.saveMap('userData', {
              "matricula_usuario": usuarioData['matricula_usuario'].toString(),
              "nome_usuario": usuarioData['nome_usuario'].toString(),
              "email_usuario": usuarioData['email_usuario'].toString(),
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
