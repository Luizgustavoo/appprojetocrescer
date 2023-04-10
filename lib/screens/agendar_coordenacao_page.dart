import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/class_horarios_atendimento.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:provider/provider.dart';

class AgendarCoordenacaoPage extends StatefulWidget {
  @override
  _AgendarCoordenacaoPageState createState() => _AgendarCoordenacaoPageState();
}

class _AgendarCoordenacaoPageState extends State<AgendarCoordenacaoPage> {
  final _tituloFocusNode = FocusNode();
  DateTime _selectedDate;
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = true;
  bool _isLoadingButton = false;

  final _controllerData = TextEditingController();
  String valueChoose;
  String valueChoose2;
  List listItem = [
    "01/04/2021",
    "02/04/2021",
    "03/04/2021",
    "04/04/2021",
    "05/04/2021",
  ];
  List listItem2 = [
    "10:00",
    "10:30",
    "11:00",
    "10:30",
  ];
  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
          _controllerData.text = DateFormat('dd/MM/y').format(pickedDate);
        });
      }
    });
  }

  void _saveForm() {
    var isValid = _form.currentState.validate();

    if (valueChoose == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Selecione uma data'),
          duration: Duration(seconds: 2),
        ),
      );

      return;
    }

    if (!isValid) return;

    print('enviado');
    _form.currentState.save();

    final dataHora = valueChoose.split(';');

    final agendamento = new AgendamentoAtendimento(
      dataAgendamento: dataHora[0],
      horaAgendamento: dataHora[1],
      matricula: Provider.of<Login>(context, listen: false).matricula,
      nomePessoa: _formData['nome'],
      setorAgendamento: "coordenacao",
      statusAgendamento: "aguardando_aprovacao",
      motivoAgendamento: _formData['motivo'],
    );

    setState(() {
      _isLoadingButton = true;
    });

    Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .cadastrar(agendamento)
        .then((value) {
      setState(() {
        valueChoose = null;
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
    Provider.of<HorariosAtendimentos>(context, listen: false)
        .loadHorarios()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataCoordenacao =
        Provider.of<HorariosAtendimentos>(context, listen: false)
            .itemsCoordenacao;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solicitar Agend. Coordenacao',
          style: TextStyle(
            fontSize: MediaQuery.of(context).textScaleFactor * 20,
          ),
        ),
        actions: [
          _isLoadingButton
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    _saveForm();
                  },
                ),
        ],
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
                    // TextFormField(
                    //   readOnly: true,
                    //   controller: _controllerData,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Data',
                    //       suffixIcon: IconButton(
                    //         icon: Icon(Icons.date_range),
                    //         onPressed: () {
                    //           _showDatePicker();
                    //         },
                    //       )),
                    //   textInputAction: TextInputAction.next,
                    //   onFieldSubmitted: (_) =>
                    //       FocusScope.of(context).requestFocus(_tituloFocusNode),
                    //   onSaved: (value) => _formData['data'] = value,
                    //   validator: (value) {
                    //     if (value.trim().length < 3) {
                    //       return 'Data inválida!';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: Text('Selecione uma data'),
                      dropdownColor: Colors.grey[350],
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 30,
                      isExpanded: true,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      value: valueChoose,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue;
                        });
                      },
                      items: dataCoordenacao.map((valueItem) {
                        return DropdownMenuItem(
                          value:
                              "${valueItem.dataDisponivel + ";" + valueItem.horaDisponivel}",
                          child: Text(
                              "${valueItem.dataDisponivel + " - " + valueItem.horaDisponivel}"),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_tituloFocusNode),
                      onSaved: (value) => _formData['nome'] = value,
                      validator: (value) {
                        if (value.trim().length < 3) {
                          return 'Campo nome deve conter no mínimo 3 caracteres!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Motivo/Assunto',
                        border: OutlineInputBorder(),
                        // icon: Icon(Icons.add_box),
                      ),
                      // textInputAction: TextInputAction.next,
                      focusNode: _tituloFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      onSaved: (value) => _formData['motivo'] = value,
                      validator: (value) {
                        if (value.trim().length < 3) {
                          return 'Campo motivo deve conter no mínimo 3 caracteres!';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
