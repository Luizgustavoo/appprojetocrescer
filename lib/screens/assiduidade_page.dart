import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_frequencias.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/frequencia_item_tile.dart';
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
        ),
      ),
      // drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              color: CustomColors.amarelo,
              onRefresh: () => loadFrequencias(context),
              child: Column(
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Chip(
                              avatar: CircleAvatar(
                                backgroundColor: Colors.blue[900],
                                child: Text(
                                  frequenciasData.totalJustificada.toString(),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            17,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              elevation: 3,
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 15,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                letterSpacing: .5,
                              ),
                              label: Container(
                                child: Text(
                                  'Justificadas',
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            Chip(
                              avatar: CircleAvatar(
                                backgroundColor: Colors.red[900],
                                child: Text(
                                  frequenciasData.totalNaoJustificada
                                      .toString(),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            17,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              elevation: 3,
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 15,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                letterSpacing: .5,
                              ),
                              label: Text(
                                'Sem Justificar',
                              ),
                              backgroundColor: Theme.of(context).errorColor,
                            ),
                          ],
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
