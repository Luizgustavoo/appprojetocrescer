import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_penalidades.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/penalidade_item.dart';
import 'package:provider/provider.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

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
      backgroundColor: CustomColors.fundo,
      appBar: AppBar(
        title: Text(
          'PENALIDADES DO ALUNO',
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              color: CustomColors.amarelo,
              onRefresh: () => loadPenalidades(context),
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
                                  penalidadesData.totalOcorrencias.toString(),
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
                                  'Ocorrências',
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            Chip(
                              avatar: CircleAvatar(
                                backgroundColor: Colors.red[900],
                                child: Text(
                                  penalidadesData.totalAdvertencias.toString(),
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
                                'Advertências',
                              ),
                              backgroundColor: Theme.of(context).errorColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: penalidadesData.itemsCount <= 0
                        ? Center(
                            child: Text(
                              'Nenhuma penalidade encontrada! \nParabéns.' +
                                  '💙',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: penalidadesData.itemsCount,
                            itemBuilder: (ctx, i) {
                              return AnimationConfiguration.staggeredList(
                                position: i,
                                duration: Duration(milliseconds: 100),
                                child: ScaleAnimation(
                                  duration: Duration(milliseconds: 500),
                                  child: PenalidadesItem(penalidades[i]),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
