import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_comunicado.dart';
import 'package:projetocrescer/utils/constants.dart';

class ComunicadosItem extends StatelessWidget {
  final Comunicado comunicado;
  ComunicadosItem(this.comunicado);

  // void _selectComunicado(BuildContext context) {
  //   if (int.parse(comunicado.visualizou) <= 0) {
  //     Provider.of<Comunicados>(context, listen: false)
  //         .visualizarComunicado(comunicado.idComunicado.toString(),
  //             Provider.of<Login>(context, listen: false).matricula.toString())
  //         .then((value) {
  //       Navigator.of(context)
  //           .pushNamed(AppRoute.DETALHES_COMUNICADOS, arguments: comunicado);
  //     });
  //   } else {
  //     Navigator.of(context)
  //         .pushNamed(AppRoute.DETALHES_COMUNICADOS, arguments: comunicado);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //  onTap: () => _selectComunicado(context),
      splashColor: Theme.of(context).colorScheme.secondary,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50)),
                  child: Hero(
                    tag: comunicado.idComunicado,
                    child: Image.network(
                      'http://' +
                          Constants.IP +
                          '/sistemaalunos/web-pages/documentos/comunicados/' +
                          comunicado.imagemComunicado,
                      height: MediaQuery.of(context).size.height * .35,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      comunicado.assuntoComunicado.toUpperCase(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.date_range),
                      SizedBox(width: 6),
                      Text(comunicado.dataComunicado)
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.people),
                      SizedBox(width: 6),
                      Text(
                        comunicado.nomeUsuario.substring(0, 10),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      int.parse(comunicado.visualizou) > 0
                          ? Icon(
                              Icons.check_box_outlined,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.check_box_outline_blank_sharp,
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
