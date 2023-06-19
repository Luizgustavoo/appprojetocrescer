import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_comunicado.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:provider/provider.dart';

class ComunicadosItem extends StatelessWidget {
  final Comunicado comunicado;
  ComunicadosItem(this.comunicado);

  void _selectComunicado(BuildContext context) {
    if (int.parse(comunicado.visualizou!) <= 0) {
      Provider.of<Comunicados>(context, listen: false)
          .visualizarComunicado(comunicado.idComunicado.toString(),
              Provider.of<Login>(context, listen: false).matricula.toString())
          .then((value) {
        Navigator.of(context)
            .pushNamed(AppRoute.DETALHES_COMUNICADOS, arguments: comunicado);
      });
    } else {
      Navigator.of(context)
          .pushNamed(AppRoute.DETALHES_COMUNICADOS, arguments: comunicado);
    }
  }

  @override
  Widget build(BuildContext context) {
    String imagem =
        'http://projetocrescer.ddns.net/sistemaalunos/web-pages/documentos/comunicados/';
    return InkWell(
      onTap: () => _selectComunicado(context),
      splashColor: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        margin: EdgeInsets.only(top: 20, right: 10, left: 10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Hero(
                    tag: comunicado.idComunicado!,
                    child: Image.network(
                      imagem + comunicado.imagemComunicado!,
                      height: MediaQuery.of(context).size.height * .34,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black87,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      comunicado.assuntoComunicado!.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).textScaleFactor * 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 25,
                      ),
                      SizedBox(width: 6),
                      Text(
                        comunicado.dataComunicado!,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 25,
                      ),
                      SizedBox(width: 6),
                      Text(
                        comunicado.nomeUsuario!.substring(0, 10),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      int.parse(comunicado.visualizou!) > 0
                          ? Icon(
                              Icons.check_box_rounded,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.check_box_outline_blank_rounded,
                              color: Colors.red,
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
