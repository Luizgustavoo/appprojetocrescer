import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/widgets/clip_path.dart';
import 'package:projetocrescer/widgets/custom_colors.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, String> _authData = {'email': '', 'senha': ''};

  bool _isLoading = false;
  bool _showPassword = false;

  GlobalKey<FormState> _form = GlobalKey();

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
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  void _submit() {
    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState.save();

    Provider.of<Login>(context, listen: false)
        .signin(_authData['email'], _authData['senha'])
        .then((value) {
      setState(() {
        _isLoading = false;
      });

      if (value == 'USER_NOT_FOUND') {
        _showErrorDialog('Usuário não encontrado');
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoute.HOME);
      }
    });
  }

  checkStatus() async {
    var result = await Connectivity().checkConnectivity();

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.withAlpha(295),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                ClipPathCustom(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
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
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            // autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: CustomColors.azul)),
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
                                  Icons.info_rounded,
                                  color: CustomColors.azul,
                                ),
                              ),
                              labelText: "Nº MATRÍCULA",
                              errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 255, 17, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              labelStyle: TextStyle(
                                color: CustomColors.azul,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "MATRÍCULA INVÁLIDA!";
                              }

                              return null;
                            },
                            onSaved: (value) => _authData['email'] = value,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: _showPassword ? false : true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: CustomColors.azul)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Nº CPF",
                              errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 255, 17, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              labelStyle: TextStyle(
                                color: CustomColors.azul,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Ubuntu',
                              ),
                              isDense: true,
                              prefixIcon: Icon(
                                Icons.lock_rounded,
                                size: 20,
                                color: CustomColors.azul,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: _showPassword
                                    ? Icon(
                                        Icons.visibility_off_rounded,
                                        color: CustomColors.azul,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye,
                                        color: CustomColors.azul,
                                      ),
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "CPF NÃO PODE SER VAZIO!";
                              } else if (value.length != 11) {
                                return "CPF DEVE CONTER 11 DIGITOS!";
                              }

                              return null;
                            },
                            onSaved: (value) => _authData['senha'] = value,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: CustomColors.azul,
                                        elevation: 3),
                                    child: Text(
                                      'ENTRAR',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.amarelo,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      checkStatus();
                                      if (resultInternet == true) {
                                        _submit();
                                      }
                                    },
                                  ),
                                ),
                          //Divisor
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
