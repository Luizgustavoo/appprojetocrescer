import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, String> _authData = {'email': '', 'senha': ''};

  bool _isLoading = false;

  GlobalKey<FormState> _form = GlobalKey();

  int onToggle = 0;

  bool resultInternet = false;

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Ocorreu um erro"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  checkStatus() async {
    var result = await Connectivity().checkConnectivity();

    if (mounted) {
      // Verifica se o widget está montado antes de atualizar o estado
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          resultInternet = true;
        });
      } else {
        setState(() {
          resultInternet = false;
        });
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Verifique sua conexão com a internet!"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _submit() {
    checkStatus();
    if (!_form.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState!.save();

    Provider.of<Login>(context, listen: false)
        .signin(_authData['email']!, _authData['senha']!, onToggle)
        .then((value) {
      setState(() {
        _isLoading = false;
      });

      if (value == 'USER_NOT_FOUND') {
        _showErrorDialog('Aluno não encontrado');
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoute.HOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 230,
                        height: 230,
                        child: Image.asset("images/logo.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToggleSwitch(
                            initialLabelIndex: 0,
                            activeFgColor: Colors.white,
                            minWidth: 150.0,
                            minHeight: 38.0,
                            cornerRadius: 8.0,
                            onToggle: (index) => onToggle = index!,
                            labels: ['ALUNO', 'PROFESSOR'],
                            activeBgColor: [
                              CustomColors.azul,
                            ],
                            customTextStyles: [
                              TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900),
                              TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.azul)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.account_circle,
                          size: 20,
                          color: CustomColors.azul,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "NÚMERO DA MATRÍCULA",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      color: CustomColors.azul,
                                    ),
                                  ),
                                  content: Text(
                                    "O número que você procura pode ser encontrado no contrato de matrícula que você assinou no momento da matrícula. Esse número está localizado entre [    ].",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Ubuntu',
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
                            color: CustomColors.azul,
                          ),
                        ),
                        labelText: "Nº MATRÍCULA",
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 17, 0),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        labelStyle: TextStyle(
                          color: CustomColors.azul,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "MATRÍCULA INVÁLIDA!";
                        }

                        return null;
                      },
                      onSaved: (value) => _authData['email'] = value!,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.azul)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Nº CPF",
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 17, 0),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        labelStyle: TextStyle(
                          color: CustomColors.azul,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          size: 20,
                          color: CustomColors.azul,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "CPF NÃO PODE SER VAZIO!";
                        } else if (value.length != 11) {
                          return "CPF DEVE CONTER 11 DIGITOS!";
                        }

                        return null;
                      },
                      onSaved: (value) => _authData['senha'] = value!,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _isLoading
                        ? Center(
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulseSync,
                                colors: [
                                  Color(0xFF130B3B),
                                  Color(0xFFEBAE1F),
                                  Color(0XFFd7f1fa),
                                ],
                                strokeWidth: 1,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.azul,
                                elevation: 3,
                              ),
                              child: Text(
                                'ENTRAR',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 1,
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                _submit();
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
