import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_frequencias.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:provider/provider.dart';

class AssiduidadePage extends StatefulWidget {
  @override
  _AssiduidadePageState createState() => _AssiduidadePageState();
}

class _AssiduidadePageState extends State<AssiduidadePage> {
  bool _isLoading = true;

  Future<void> loadFrequencias(BuildContext context) {
    final usuarioData = Provider.of<Login>(context, listen: false);

    return Provider.of<Frequencias>(context, listen: false)
        .loadFrequencias(Provider.of<Login>(context, listen: false).matricula)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadFrequencias(context);
  }

  Widget build(BuildContext context) {
    final frequenciasData = Provider.of<Frequencias>(context);
    final frequencias = frequenciasData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FREQUENCIAS DO(A) ALUNO(A)',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).textScaleFactor * 20,
          ),
        ),
      ),
      // drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => loadFrequencias(context),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 40,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Justificadas: ',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          15,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  frequenciasData.totalJustificada.toString(),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            15,
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                              Text(
                                'Sem justificar: ',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          15,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  frequenciasData.totalNaoJustificada
                                      .toString(),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            15,
                                  ),
                                ),
                                backgroundColor: Theme.of(context).errorColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: frequenciasData.itemsCount,
                      itemBuilder: (ctx, i) {
                        return FrequenciasItem(frequencias[i]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class FrequenciasItem extends StatefulWidget {
  final Frequencia _frequencia;

  FrequenciasItem(this._frequencia);

  @override
  _FrequenciasItemState createState() => _FrequenciasItemState();
}

class _FrequenciasItemState extends State<FrequenciasItem> {
  bool _expanded = false;

  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
      height: _expanded ? 196 : 96,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                onTap: widget._frequencia.justificado == 'sim'
                    ? () {
                        setState(() {
                          _expanded = !_expanded;
                        });

                        // animação quando clicar aqui
                      }
                    : null,
                title: Text(
                  widget._frequencia.tipoFalta,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).textScaleFactor * 18,
                  ),
                ),
                subtitle: Text(
                  widget._frequencia.dataFrequencia,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                leading: Image.asset((widget._frequencia.justificado == 'sim')
                    ? 'images/positivo.png'
                    : 'images/negativo.png'),
                trailing: IconButton(
                  icon: (widget._frequencia.justificado == 'sim')
                      ? _expanded
                          ? Icon(Icons.expand_less)
                          : Icon(Icons.expand_more)
                      : Icon(Icons.block),
                  onPressed: widget._frequencia.justificado == 'sim'
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
                height: _expanded ? 100 : 0,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListView(
                  children: [
                    Text(
                      widget._frequencia.justificativa,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
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
