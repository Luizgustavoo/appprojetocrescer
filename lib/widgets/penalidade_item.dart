import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_penalidades.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class PenalidadesItem extends StatefulWidget {
  final Penalidade _penalidade;

  PenalidadesItem(this._penalidade);

  @override
  _PenalidadesItemState createState() => _PenalidadesItemState();
}

class _PenalidadesItemState extends State<PenalidadesItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
      height: _expanded ? 280 : 96,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                title: Text(
                  widget._penalidade.descricaoTipoPenalidade!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).textScaleFactor * 17,
                    fontFamily: 'Montserrat',
                    color: CustomColors.azul,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "DATA: " + widget._penalidade.dataPenalidade!,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Image.asset(
                    int.parse(widget._penalidade.tipoPenalidade!) <= 1
                        ? 'images/penalidades.png'
                        : 'images/perigo.png'),
                trailing: IconButton(
                  icon: _expanded
                      ? Icon(
                          Icons.expand_less_rounded,
                          size: 30,
                          color: CustomColors.azul,
                        )
                      : Icon(
                          Icons.expand_more_rounded,
                          size: 30,
                          color: CustomColors.azul,
                        ),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                height: _expanded ? 180 : 0,
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: ListView(
                  children: [
                    Text(
                      widget._penalidade.observacao!,
                      style: TextStyle(
                        color: CustomColors.azul,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: .1,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
