// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projetocrescer/preferences/store.dart';
import 'package:projetocrescer/utils/constants.dart';
import 'package:http/http.dart' as http;

class Perfil {
  final String? idPessoa;
  final String? nomePessoa;
  final String? nascimentoPessoa;
  final String? celularPessoa;
  final String? cpfPessoa;
  final String? rgPessoa;
  final String? emailPessoa;
  final String? enderecoPessoa;
  final String? bairroPessoa;
  final String? cepPessoa;
  final String? numeroEnderecoPessoa;
  final String? periodoMatricula;
  final String? nomeEscola;
  final String? telefoneEscola;
  final String? descricaoInstituicao;
  final String? fotoPessoa;
  Perfil({
    this.idPessoa,
    this.nomePessoa,
    this.nascimentoPessoa,
    this.celularPessoa,
    this.cpfPessoa,
    this.rgPessoa,
    this.emailPessoa,
    this.enderecoPessoa,
    this.bairroPessoa,
    this.cepPessoa,
    this.numeroEnderecoPessoa,
    this.periodoMatricula,
    this.nomeEscola,
    this.telefoneEscola,
    this.descricaoInstituicao,
    this.fotoPessoa,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_pessoa': idPessoa,
      'nome_pessoa': nomePessoa,
      'nascimento_pessoa': nascimentoPessoa,
      'celular_pessoa': celularPessoa,
      'cpf_pessoa': cpfPessoa,
      'rg_pessoa': rgPessoa,
      'email_pessoa': emailPessoa,
      'endereco_pessoa': enderecoPessoa,
      'bairro_pessoa': bairroPessoa,
      'cep_pessoa': cepPessoa,
      'numero_endereco_pessoa': numeroEnderecoPessoa,
      'periodo_matricula': periodoMatricula,
      'nome_escola': nomeEscola,
      'telefone_escola': telefoneEscola,
      'descricao_instituicao': descricaoInstituicao,
      'foto_pessoa': fotoPessoa,
    };
  }

  factory Perfil.fromMap(Map<String, dynamic> map) {
    return Perfil(
      idPessoa: map['id_pessoa'] != null ? map['id_pessoa'] as String : null,
      nomePessoa:
          map['nome_pessoa'] != null ? map['nome_pessoa'] as String : null,
      nascimentoPessoa: map['nascimento_pessoa'] != null
          ? map['nascimento_pessoa'] as String
          : null,
      celularPessoa: map['celular_pessoa'] != null
          ? map['celular_pessoa'] as String
          : null,
      cpfPessoa: map['cpf_pessoa'] != null ? map['cpf_pessoa'] as String : null,
      rgPessoa: map['rg_pessoa'] != null ? map['rg_pessoa'] as String : null,
      emailPessoa:
          map['email_pessoa'] != null ? map['email_pessoa'] as String : null,
      enderecoPessoa: map['endereco_pessoa'] != null
          ? map['endereco_pessoa'] as String
          : null,
      bairroPessoa:
          map['bairro_pessoa'] != null ? map['bairro_pessoa'] as String : null,
      cepPessoa: map['cep_pessoa'] != null ? map['cep_pessoa'] as String : null,
      numeroEnderecoPessoa: map['numero_endereco_pessoa'] != null
          ? map['numero_endereco_pessoa'] as String
          : null,
      periodoMatricula: map['periodo_matricula'] != null
          ? map['periodo_matricula'] as String
          : null,
      nomeEscola:
          map['nome_escola'] != null ? map['nome_escola'] as String : null,
      telefoneEscola: map['telefone_escola'] != null
          ? map['telefone_escola'] as String
          : null,
      descricaoInstituicao: map['descricao_instituicao'] != null
          ? map['descricao_instituicao'] as String
          : null,
      fotoPessoa:
          map['foto_pessoa'] != null ? map['foto_pessoa'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Perfil.fromJson(String source) =>
      Perfil.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Perfis with ChangeNotifier {
  final String _baseUrl = Constants.URL_DADOS_ALUNO;

  List<Perfil> _items = [];
  List<Perfil> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadAccounts() async {
    Map<String, dynamic> maps = jsonDecode(await Store.getString('userData'));
    var matricula = maps['matricula_usuario'];
    var _base = Uri.parse('$_baseUrl/$matricula');
    final response = await http.get(_base);
    final data = json.decode(response.body);
    _items.clear();
    data.forEach((dados) {
      _items.add(Perfil.fromMap(dados));
    });
    notifyListeners();
    return Future.value();
  }
}
