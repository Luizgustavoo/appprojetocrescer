import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/login.dart';
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
    var isValid = _form.currentState.validate();

    if (!isValid) return;
    _form.currentState.save();

    final agendamento = new AgendamentoAtendimento(
      idMatricula: Provider.of<Login>(context, listen: false).matricula,
      nomeResponsavel: _formData['nome'],
      setorAgendamento: "coordenacao",
      statusAgendamento: "aguardando",
      motivoAgendamento: _formData['motivo'],
    );

    setState(() {
      _isLoadingButton = false;
    });

    Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .cadastrar(agendamento)
        .then((value) {
      setState(() {
        _isLoadingButton = false;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value.toString()),
            duration: Duration(seconds: 2),
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
          'Solicitar Agend. Coordenacao',
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
                          'Solicite uma visita com a coordenação da escola através do nosso aplicativo.',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 18,
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
                          Text('Nome Aluno: Luiz Gustavo da Silva'),
                          Text('Série: 6º ANO'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
