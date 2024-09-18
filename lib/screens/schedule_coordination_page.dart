import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetocrescer/models/class_scheduling.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/routes/app_route.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/custom_rich_text.dart';
import 'package:provider/provider.dart';

class CoordinationSchedulePage extends StatefulWidget {
  @override
  _CoordinationSchedulePageState createState() =>
      _CoordinationSchedulePageState();
}

class _CoordinationSchedulePageState extends State<CoordinationSchedulePage> {
  final _tituloFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = true;

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
    });

    Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .cadastrar(agendamento)
        .then((value) {
      setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    var serie = Provider.of<Login>(context).serie.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solicitar Agend. Coordenação',
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichTextWidget(
                            label: 'NOME DO ALUNO',
                            value: Provider.of<Login>(context)
                                .usuarioMatricula
                                .toString(),
                          ),
                          Text(
                            serie +
                                (serie == 'oficineiro' ? 'oficineiro' : 'º ANO')
                                    .toUpperCase(),
                            style: TextStyle(
                              color: CustomColors.azul,
                              fontFamily: 'Montserrat',
                              fontSize: 18,
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
                        isDense: true,
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Ubuntu',
                        ),
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
                        isDense: true,
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.azul,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                _saveForm();
                              },
                              child: Text(
                                'SOLICITAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
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
