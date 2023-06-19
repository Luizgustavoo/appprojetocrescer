import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_comunicado.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class ComunicadoDetalhePage extends StatefulWidget {
  @override
  State<ComunicadoDetalhePage> createState() => _ComunicadoDetalhePageState();
}

class _ComunicadoDetalhePageState extends State<ComunicadoDetalhePage> {
  String imagem =
      'http://projetocrescer.ddns.net/sistemaalunos/web-pages/documentos/comunicados/';

  @override
  Widget build(BuildContext context) {
    final comunicado = ModalRoute.of(context)?.settings.arguments as Comunicado;

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(false);
        return Provider.of<Comunicados>(context, listen: false).loadComunicados(
            Provider.of<Login>(context, listen: false).matricula!);
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                elevation: 0,
                centerTitle: true,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    comunicado.assuntoComunicado!.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: MediaQuery.of(context).textScaleFactor * 15,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: comunicado.idComunicado!,
                        child: Image.network(
                          imagem + comunicado.imagemComunicado!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0, 0.8),
                            end: Alignment(0, 0),
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0.7),
                              Color.fromRGBO(0, 0, 0, 0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "ATENÇÃO AO RECADO ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red[600],
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Divider(
                            color: CustomColors.azul,
                            thickness: 5,
                          ),
                          int.parse(comunicado.visualizou!) > 0
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      ' Lido',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ],
                                )
                              : Icon(
                                  Icons.check,
                                  color: Colors.red,
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Divider(
                        color: CustomColors.azul,
                        thickness: 2,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Text(
                          comunicado.descricaoComunicado!.toUpperCase(),
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 16,
                            fontFamily: 'Ubuntu',
                          ),
                          textAlign: TextAlign.justify,
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
