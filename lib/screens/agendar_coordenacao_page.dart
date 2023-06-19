import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class AgendarCoordenacaoPage extends StatefulWidget {
  @override
  _AgendarCoordenacaoPageState createState() => _AgendarCoordenacaoPageState();
}

class _AgendarCoordenacaoPageState extends State<AgendarCoordenacaoPage> {
  final _tituloFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = true;
  bool _isLoadingButton = true;

  void _saveForm() {
    final focusNode = FocusScope.of(context);
    var isValid = _form.currentState!.validate();

    if (!isValid) return;
    _form.currentState?.save();

    final agendamento = AgendamentoAtendimento(
      idMatricula: Provider.of<Login>(context, listen: false).matricula,
      nomeResponsavel: _formData['nome'] as String,
      dataAgendamento: DateFormat('dd/MM/y').format(DateTime.now()),
      horaAgendamento: DateFormat('Hms').format(DateTime.now()),
      setorAgendamento: "coordenacao",
      statusAgendamento: "aguardando",
      motivoAgendamento: _formData['motivo'] as String,
    );

    setState(() {
      focusNode.unfocus();
      Navigator.of(context)
          .pushReplacementNamed(AppRoute.LIST_AGENDAMENTOS_COORDENACAO);
      _isLoadingButton = false;
    });

    Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .cadastrar(agendamento)
        .then((value) {
      setState(() {
        _isLoadingButton = false;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
              ),
            ),
            duration: Duration(seconds: 4),
          ),
        );
      });

      _form.currentState!.reset();
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = false;
      _isLoadingButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solicitar Agend. Coordenacao',
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            color: Colors.blue[600],
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                      'Solicite uma conversa com a coordenação do Projeto Crescer através do nosso aplicativo.',
                                      textAlign: TextAlign.justify,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Ubuntu',
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          "Fechar",
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: CustomColors.azul,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              FontAwesomeIcons.circleInfo,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NOME ALUNO: ' +
                                Provider.of<Login>(context)
                                    .usuarioMatricula
                                    .toString(),
                            style: TextStyle(
                              color: CustomColors.azul,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Text(
                            'SÉRIE: ' +
                                Provider.of<Login>(context).serie.toString() +
                                'º ANO',
                            style: TextStyle(
                              color: CustomColors.azul,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nome do responsável',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_tituloFocusNode),
                      onSaved: (value) => _formData['nome'] = value!,
                      validator: (value) {
                        if (value!.trim().length < 4) {
                          return 'Campo nome deve conter no mínimo 4 caracteres!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Motivo/Assunto',
                      ),
                      // textInputAction: TextInputAction.next,
                      focusNode: _tituloFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      onSaved: (value) => _formData['motivo'] = value!,
                      validator: (value) {
                        if (value!.trim().length < 8) {
                          return 'Campo motivo deve conter no mínimo 8 caracteres!';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.azul,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                _saveForm();
                              },
                              icon: Icon(Icons.check_rounded),
                              label: Text(
                                'SOLICITAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
