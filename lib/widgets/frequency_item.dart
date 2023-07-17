import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_frequency.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class FrequencyItem extends StatefulWidget {
  final Frequencia _frequencia;

  FrequencyItem(this._frequencia);

  @override
  _FrequencyItemState createState() => _FrequencyItemState();
}

class _FrequencyItemState extends State<FrequencyItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
      height: _expanded ? 196 : 110,
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
                onTap: widget._frequencia.justificado == 'SIM'
                    ? () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      }
                    : null,
                title: Text(
                  widget._frequencia.descricaoTipoFalta
                      .toString()
                      .toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).textScaleFactor * 13,
                    fontFamily: 'Montserrat',
                    color: CustomColors.azul,
                  ),
                ),
                subtitle: Text(
                  widget._frequencia.dataFrequencia!,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                leading: Image.asset((widget._frequencia.justificado == 'SIM')
                    ? 'images/positivo.png'
                    : 'images/negativo.png'),
                trailing: IconButton(
                  icon: (widget._frequencia.justificado == 'SIM')
                      ? _expanded
                          ? Icon(
                              Icons.expand_less,
                              size: 30,
                              color: CustomColors.azul,
                            )
                          : Icon(
                              Icons.expand_more,
                              size: 30,
                              color: CustomColors.azul,
                            )
                      : Icon(Icons.block),
                  onPressed: widget._frequencia.justificado == 'SIM'
                      ? () {
                          setState(() {
                            _expanded = !_expanded;
                          });
                          // animação quando clicar aqui
                        }
                      : null,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                height: _expanded ? 50 : 0,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      widget._frequencia.justificativa!,
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
