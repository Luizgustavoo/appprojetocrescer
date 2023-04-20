import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_pendencias.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class PendenciasItem extends StatefulWidget {
  final Pendencia _pendencia;

  PendenciasItem(this._pendencia);

  @override
  _PendenciasItemState createState() => _PendenciasItemState();
}

class _PendenciasItemState extends State<PendenciasItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    var imagem = "";
    if (widget._pendencia.descricaoTipoPendencia.contains('CRACHÁ')) {
      imagem = 'images/crachaa.png';
    } else if (widget._pendencia.descricaoTipoPendencia.contains('LIVRO')) {
      imagem = 'images/livro.png';
    } else if (widget._pendencia.descricaoTipoPendencia.contains('CHAVE')) {
      imagem = 'images/chave.png';
    } else if (widget._pendencia.descricaoTipoPendencia.contains('FIGURINO')) {
      imagem = 'images/figurino.png';
    } else if (widget._pendencia.descricaoTipoPendencia.contains('FLAUTA')) {
      imagem = 'images/flauta.png';
    } else if (widget._pendencia.descricaoTipoPendencia.contains('MÁSCARA')) {
      imagem = 'images/mascara.png';
    } else if (widget._pendencia.descricaoTipoPendencia.contains('UNIFORME')) {
      imagem = 'images/uniforme.png';
    } else {
      imagem = 'images/perigo.png';
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (bool expanded) {
            setState(() {
              _expanded = expanded;
            });
          },
          initiallyExpanded: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget._pendencia.descricaoTipoPendencia,
                  style: const TextStyle(
                    fontSize: 25,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                color: _expanded ? CustomColors.azul : Colors.white,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DATA: " + widget._pendencia.dataPendencia,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "STATUS: " + widget._pendencia.statusPendencia,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          leading: Image.asset(imagem, fit: BoxFit.cover),
          trailing: _expanded
              ? Icon(
                  Icons.arrow_drop_up,
                  color: CustomColors.azul,
                  size: 40,
                )
              : Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 40,
                ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          textColor: CustomColors.azul,
          collapsedTextColor: Colors.white,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          collapsedBackgroundColor: CustomColors.azul,
          backgroundColor: Colors.grey.shade100,
          subtitle: _expanded && widget._pendencia.statusPendencia == 'ativo'
              ? Container(
                  child: Text(
                    widget._pendencia.observacao,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Ubunutu',
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              : _expanded && widget._pendencia.statusPendencia == 'inativo'
                  ? Container(
                      child: Text(
                        'JÁ HOUVE UM ACORDO COM A COORDENAÇÃO.',
                        style: TextStyle(
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubunutu',
                          fontSize: 13,
                        ),
                      ),
                    )
                  : Container(),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(7.0),
      elevation: 4,
    );
  }
}
