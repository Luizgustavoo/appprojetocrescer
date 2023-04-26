import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projetocrescer/utils/constants.dart';

class Comunicado {
  final String idComunicado;
  final String dataComunicado;
  final String destinatarioComunicado;
  final String assuntoComunicado;
  final String descricaoComunicado;
  final String imagemComunicado;
  final String nomeUsuario;
  final String statusComunicado;
  final String visualizou;

  Comunicado({
    this.idComunicado,
    this.dataComunicado,
    this.destinatarioComunicado,
    this.assuntoComunicado,
    this.descricaoComunicado,
    this.imagemComunicado,
    this.nomeUsuario,
    this.statusComunicado,
    this.visualizou,
  });
}

class Comunicados with ChangeNotifier {
  List<Comunicado> _items = [];
  final String _baseUrl = Constants.URL_COMUNICADOS;

  List<Comunicado> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<bool> loadComunicados(String matricula) async {
    var _base = Uri.parse('$_baseUrl/$matricula');
    final response = await http.get(_base);

    final data = json.decode(response.body);
    _items.clear();

    if (data != null) {
      data.forEach((dados) {
        _items.add(
          Comunicado(
            idComunicado: dados['id_comunicado'].toString(),
            dataComunicado: DateFormat('dd/MM/y')
                .format(DateTime.parse(dados['data_comunicado'].toString())),
            destinatarioComunicado: dados['destinatario_comunicado'].toString(),
            assuntoComunicado: dados['assunto_comunicado'].toString(),
            descricaoComunicado: dados['descricao_comunicado'].toString(),
            imagemComunicado: dados['imagem_comunicado'].toString(),
            nomeUsuario: dados['nome_usuario'].toString(),
            statusComunicado: dados['status_comunicado'].toString(),
            visualizou: dados['visualizou'].toString(),
          ),
        );
      });
      notifyListeners();
    }

    return Future.value();
  }

  Future<String> visualizarComunicado(
      String comunicado, String matricula) async {
    String retorno = "fail";
    var _baseUrl = Uri.parse(Constants.URL_VIEW_COMUNICADO);

    final response = await http.post(
      _baseUrl,
      body: {
        "comunicado": comunicado,
        "matricula": matricula,
      },
    );

    if (response.body.contains('return')) {
      retorno = json.decode(response.body)['return'];
    }

    notifyListeners();
    return Future.value(retorno);
  }
}
