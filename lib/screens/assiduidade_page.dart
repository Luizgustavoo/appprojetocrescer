import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_frequencias.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/frequencia_item_tile.dart';
import 'package:provider/provider.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class AssiduidadePage extends StatefulWidget {
  @override
  _AssiduidadePageState createState() => _AssiduidadePageState();
}

class _AssiduidadePageState extends State<AssiduidadePage> {
  bool _isLoading = true;

  Future<void> loadFrequencias(BuildContext context) {
    return Provider.of<Frequencias>(context, listen: false)
        .loadFrequencias(Provider.of<Login>(context, listen: false).matricula!)
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
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Chip(
                              side: BorderSide.none,
                              avatar: CircleAvatar(
                                backgroundColor: Colors.green.shade400,
                                child: Text(
                                  frequenciasData.totalJustificada.toString(),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            15,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
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
                                  'JUSTIFICADAS',
                                ),
                              ),
                              backgroundColor: Colors.green.shade900,
                            ),
                            Chip(
                              side: BorderSide.none,
                              avatar: CircleAvatar(
                                backgroundColor: Colors.red.shade500,
                                child: Text(
                                  frequenciasData.totalNaoJustificada
                                      .toString(),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            15,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 15,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                letterSpacing: .5,
                              ),
                              label: Text(
                                'SEM JUSTIFICAR',
                              ),
                              backgroundColor: Colors.red.shade900,
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
                        return AnimationConfiguration.staggeredList(
                            delay: Duration(milliseconds: 5),
                            position: i,
                            duration: Duration(milliseconds: 100),
                            child: ScaleAnimation(
                              duration: Duration(milliseconds: 500),
                              child: FrequenciasItem(frequencias[i]),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
