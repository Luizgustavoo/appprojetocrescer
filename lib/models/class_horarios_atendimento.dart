import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projetocrescer/utils/constants.dart';

class HorarioAtendimento {
  final String dataDisponivel;
  final String horaDisponivel;
  final String setor;
  final String quantidadePessoas;
  final String agendado;

  HorarioAtendimento({
    this.dataDisponivel,
    this.horaDisponivel,
    this.setor,
    this.quantidadePessoas,
    this.agendado,
  });
}

class HorariosAtendimentos with ChangeNotifier {
  List<HorarioAtendimento> _items = [];
  final Uri _baseUrl = Uri.parse(Constants.URL_HORARIOS_ATENDIMENTO);

  List<HorarioAtendimento> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

//  int get totalJustificada {
//     return _items.where((frequencia) => frequencia.justificado == 'sim').toList().length;
//   }

  List<HorarioAtendimento> get itemsCoordenacao {
    return _items
        .where((coordenacao) =>
            coordenacao.setor.toLowerCase() == 'coordenacao' &&
            (int.parse(coordenacao.quantidadePessoas) >
                int.parse(coordenacao.agendado)))
        .toList();
  }

  List<HorarioAtendimento> get itemsPsicologo {
    return _items
        .where((psicologo) =>
            psicologo.setor.toLowerCase() == 'psicologo' &&
            (int.parse(psicologo.quantidadePessoas) >
                int.parse(psicologo.agendado)))
        .toList();
  }

  Future<void> loadHorarios() async {
    final response = await http.get(_baseUrl);

    final data = json.decode(response.body);
    _items.clear();

    data.forEach((dados) {
      _items.add(
        HorarioAtendimento(
          dataDisponivel: DateFormat('dd/MM/y')
              .format(DateTime.parse(dados['data_disponivel'].toString())),
          horaDisponivel: dados['hora_disponivel'].toString(),
          setor: dados['setor'].toString(),
          quantidadePessoas: dados['quantidade_pessoas'].toString(),
          agendado: dados['agendado'].toString(),
        ),
      );
    });
    notifyListeners();
    return Future.value();
  }
}
