import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_pendencias.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:provider/provider.dart';

class PendecniasPage extends StatefulWidget {
  @override
  _PendecniasPageState createState() => _PendecniasPageState();
}

class _PendecniasPageState extends State<PendecniasPage> {
  bool _isLoading = true;

  Future<void> loadPendencias(BuildContext context) {
    // final usuarioData = Provider.of<Login>(context, listen: false);

    return Provider.of<Pendencias>(context, listen: false)
        .loadPendencias(Provider.of<Login>(context, listen: false).matricula)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadPendencias(context);
  }

  Widget build(BuildContext context) {
    final pendenciasData = Provider.of<Pendencias>(context);
    final pendencias = pendenciasData.items;

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          title: Text(
            'PENDÊNCIAS DO ALUNO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).textScaleFactor * 20,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(70),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => loadPendencias(context),
              child: Column(
                children: [
                  Expanded(
                    child: pendenciasData.itemsCount <= 0
                        ? Center(
                            child:
                                Text('Nenhuma pendência encontrada! Parabéns.'),
                          )
                        : ListView.builder(
                            itemCount: pendenciasData.itemsCount,
                            itemBuilder: (ctx, i) {
                              return PendenciasItem(pendencias[i]);
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}

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

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
      height: _expanded ? 200 : 96,
      child: Card(
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
                  widget._pendencia.descricaoTipoPendencia,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  widget._pendencia.dataPendencia +
                      " - Status: " +
                      widget._pendencia.statusPendencia,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                leading: Image.asset(imagem),
                trailing: widget._pendencia.statusPendencia == 'ativo'
                    ? Icon(
                        Icons.dangerous,
                        size: 50,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.warning,
                        size: 50,
                        color: Colors.green,
                      ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                height: _expanded ? 100 : 0,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListView(
                  children: [
                    Text(
                      widget._pendencia.observacao,
                      style: TextStyle(
                          color: widget._pendencia.statusPendencia == 'ativo'
                              ? Theme.of(context).errorColor
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.left,
                    )
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
