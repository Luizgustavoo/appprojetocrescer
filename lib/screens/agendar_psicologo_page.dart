import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class AgendarPsicologoPage extends StatefulWidget {
  @override
  _AgendarPsicologoPageState createState() => _AgendarPsicologoPageState();
}

class _AgendarPsicologoPageState extends State<AgendarPsicologoPage> {
  final _tituloFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = true;
  bool _isLoadingButton = true;

  void _saveForm() {
    final focusNode = FocusScope.of(context);
    var isValid = _form.currentState.validate();

    if (!isValid) return;
    _form.currentState.save();

    final agendamento = new AgendamentoAtendimento(
      idMatricula: Provider.of<Login>(context, listen: false).matricula,
      nomeResponsavel: _formData['nome'],
      dataAgendamento: DateFormat('dd/MM/y').format(DateTime.now()),
      horaAgendamento: DateFormat('Hms').format(DateTime.now()),
      setorAgendamento: "psicologo",
      statusAgendamento: "aguardando",
      motivoAgendamento: _formData['motivo'],
    );

    setState(() {
      focusNode.unfocus();
      Navigator.of(context)
          .pushReplacementNamed(AppRoute.LIST_AGENDAMENTOS_PSICOLOGO);
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

      _form.currentState.reset();
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
          'Solicitar Agend. Psicólogo',
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 5,
                      ),
                      child: Center(
                        child: Text(
                          'Solicite uma conversa com um de nossos psicólogos do Projeto Crescer através do nosso aplicativo.',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                      onSaved: (value) => _formData['nome'] = value,
                      validator: (value) {
                        if (value.trim().length < 4) {
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
                      onSaved: (value) => _formData['motivo'] = value,
                      validator: (value) {
                        if (value.trim().length < 8) {
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
                              onPressed: _isLoadingButton
                                  ? CircularProgressIndicator()
                                  : () {
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