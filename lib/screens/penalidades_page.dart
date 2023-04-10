import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_penalidades.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:provider/provider.dart';

class PenalidadesPage extends StatefulWidget {
  @override
  _PenalidadesPageState createState() => _PenalidadesPageState();
}

class _PenalidadesPageState extends State<PenalidadesPage> {
  bool _isLoading = true;

  Future<void> loadPenalidades(BuildContext context) {
    // final usuarioData = Provider.of<Login>(context, listen: false);

    return Provider.of<Penalidades>(context, listen: false)
        .loadPenalidades(Provider.of<Login>(context, listen: false).matricula)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadPenalidades(context);
  }

  Widget build(BuildContext context) {
    final penalidadesData = Provider.of<Penalidades>(context);
    final penalidades = penalidadesData.items;

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          title: Text(
            'PENALIDADES DO ALUNO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).textScaleFactor * 20,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(70),
      ),
      // drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => loadPenalidades(context),
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
                                'Ocorrências: ',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          15,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  penalidadesData.totalOcorrencias.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            15,
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                              Text(
                                'Advertências: ',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          15,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  penalidadesData.totalAdvertencias.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            15,
                                  ),
                                ),
                                backgroundColor: Theme.of(context).errorColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: penalidadesData.itemsCount,
                      itemBuilder: (ctx, i) {
                        return PenalidadesItem(penalidades[i]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

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
                  widget._penalidade.descricaoTipoPenalidade,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).textScaleFactor * 15,
                  ),
                ),
                subtitle: Text(
                  widget._penalidade.dataPenalidade,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                leading: Image.asset(
                    int.parse(widget._penalidade.tipoPenalidade) <= 1
                        ? 'images/penalidades.png'
                        : 'images/perigo.png'),
                trailing: IconButton(
                  icon: _expanded
                      ? Icon(Icons.expand_less)
                      : Icon(Icons.expand_more),
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
                height: _expanded ? 100 : 0,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListView(
                  children: [
                    Text(
                      widget._penalidade.observacao,
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
