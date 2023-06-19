import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class AgendamentosItem extends StatefulWidget {
  final AgendamentoAtendimento agendamento;

  AgendamentosItem(this.agendamento);

  @override
  _AgendamentosItemState createState() => _AgendamentosItemState();
}

class _AgendamentosItemState extends State<AgendamentosItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    String imagem = 'images/finalizado.png';
    if (widget.agendamento.statusAgendamento
        .toString()
        .toLowerCase()
        .contains("confirmado")) {
      imagem = 'images/confirmado.png';
    }

    if (widget.agendamento.statusAgendamento
        .toString()
        .toLowerCase()
        .contains("aguardando")) {
      imagem = 'images/aguardando.png';
    }

    if (widget.agendamento.statusAgendamento
        .toString()
        .toLowerCase()
        .contains("adiado")) {
      imagem = 'images/adiado.png';
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
      height: _expanded ? 250 : 96,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
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
                  widget.agendamento.statusAgendamento!.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: CustomColors.azul,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).textScaleFactor * 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    widget.agendamento.dataAgendamento! +
                        " - " +
                        widget.agendamento.horaAgendamento!,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Image.asset(imagem),
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
                height: _expanded ? 150 : 0,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: ListView(
                  children: [
                    Text(
                      widget.agendamento.motivoAgendamento!,
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
