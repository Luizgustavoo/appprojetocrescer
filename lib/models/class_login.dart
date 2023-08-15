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
  final String? qrCode;
  final String? idInstituicao;
  final String? periodoMatricula;

  Usuario({
    // ignore: non_constant_identifier_names
    this.matriculaUsuario,
    this.nomeUsuario,
    this.emailUsuario,
    this.foto,
    this.serieMatricula,
    this.qrCode,
    this.idInstituicao,
    this.periodoMatricula,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matricula_usuario': matriculaUsuario,
      'nome_usuario': nomeUsuario,
      'email_usuario': emailUsuario,
      'foto': foto,
      'serie_matricula': serieMatricula,
      'qr_code': qrCode,
      'id_instituicao': idInstituicao,
      'periodo_matricula': periodoMatricula,
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
      qrCode: map['qr_code'] != null ? map['qr_code'] as String : null,
      idInstituicao: map['id_instituicao'] != null
          ? map['id_instituicao'] as String
          : null,
      periodoMatricula: map['periodo_matricula'] != null
          ? map['periodo_matricula'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Login with ChangeNotifier {
  final Uri _baseUrl = Uri.parse(Constants.URL_LIST_USUARIOS);
  List<Usuario> _items = [];

  List<Usuario> get items => [..._items];

  String? _matricula;
  String? _usuarioMatricula;
  String? _foto;
  String? _serieMatricula;
  String? _qrCode;
  String? _idInstituicao;
  String? _periodoMatricula;

  int get itemsCount {
    return _items.length;
  }

  // ignore: missing_return
  String? get serie {
    return _serieMatricula;
  }

  String? get qrCode {
    return _qrCode;
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

  String? get idInstituicao {
    return _idInstituicao;
  }

  String? get periodoMatricula {
    return _periodoMatricula;
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
    _qrCode = null;
    _idInstituicao = null;
    _periodoMatricula = null;
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
      _qrCode = userData["qr_code"].toString();
      _idInstituicao = userData["id_instituicao"].toString();
      _periodoMatricula = userData["periodo_matricula"].toString();

      notifyListeners();
      return Future.value();
    }
  }

  Future<String> signin(String email, String senha, int tipoLogin) async {
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
        _items.clear();
        var data = json.decode(response.body);

        if (data != null) {
          _items.add(
            Usuario(
              matriculaUsuario: data['matricula_usuario'].toString(),
              nomeUsuario: data['nome_usuario'].toString(),
              emailUsuario: data['email_usuario'].toString(),
              foto: data['foto'].toString(),
              serieMatricula: data['serie_matricula'].toString(),
              qrCode: data['qr_code'].toString(),
              idInstituicao: data['id_instituicao'].toString(),
              periodoMatricula: data['periodo_matricula'].toString(),
            ),
          );

          _matricula = data['matricula_usuario'].toString();
          _usuarioMatricula = data['nome_usuario'].toString();
          _foto = data['foto'].toString();
          _serieMatricula = data['serie_matricula'].toString();
          _qrCode = data['qr_code'].toString();
          _idInstituicao = data['id_instituicao'].toString();
          _periodoMatricula = data['periodo_matricula'].toString();

          Store.saveMap('userData', {
            "matricula_usuario": data['matricula_usuario'].toString(),
            "nome_usuario": data['nome_usuario'].toString(),
            "email_usuario": data['email_usuario'].toString(),
            "foto": data['foto'].toString(),
            "serie_matricula": data['serie_matricula'].toString(),
            "qr_code": data['qr_code'].toString(),
            "id_instituicao": data['id_instituicao'].toString(),
            "periodo_matricula": data['periodo_matricula'].toString(),
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

  Future<String> pegarCracha() async {
    Map<String, dynamic> maps = jsonDecode(await Store.getString('userData'));
    var qrCode = maps['qr_code'];
    return qrCode;
  }
}
