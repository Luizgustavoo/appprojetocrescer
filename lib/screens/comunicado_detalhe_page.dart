import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_comunicado.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/constants.dart';
import 'package:provider/provider.dart';

class ComunicadoDetalhePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comunicado = ModalRoute.of(context).settings.arguments as Comunicado;

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(false);
        return Provider.of<Comunicados>(context, listen: false).loadComunicados(
            Provider.of<Login>(context, listen: false).matricula);
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     comunicado.assunto_comunicado.toUpperCase(),
        //     style: TextStyle(
        //         fontSize: MediaQuery.of(context).textScaleFactor * 18),
        //   ),
        // ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  comunicado.assuntoComunicado.toUpperCase(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 16),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: comunicado.idComunicado,
                      child: Image.network(
                        'http://' +
                            Constants.IP +
                            '/sistemaalunos/web-pages/documentos/comunicados/' +
                            comunicado.imagemComunicado,
                        height: 250,
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
                            Color.fromRGBO(0, 0, 0, 0.6),
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
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Descrição",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 20,
                              fontWeight: FontWeight.bold),
                        ),
                        int.parse(comunicado.visualizou) > 0
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'lido',
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      comunicado.descricaoComunicado.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: MediaQuery.of(context).textScaleFactor * 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 1000,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
