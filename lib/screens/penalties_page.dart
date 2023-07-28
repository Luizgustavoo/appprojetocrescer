import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_penalties.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/penalty_item.dart';
import 'package:provider/provider.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class PenaltiesPage extends StatefulWidget {
  @override
  _PenaltiesPageState createState() => _PenaltiesPageState();
}

class _PenaltiesPageState extends State<PenaltiesPage> {
  bool _isLoading = true;

  Future<void> loadPenalidades(BuildContext context) async {
    final matricula = Provider.of<Login>(context, listen: false).matricula;
    if (matricula != null) {
      await Provider.of<Penalidades>(context, listen: false)
          .loadPenalidades(matricula);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPenalidades(context);
  }

  Widget _buildPenaltyItem(BuildContext context, int index) {
    final penalidadesData = Provider.of<Penalidades>(context);
    final penalidades = penalidadesData.items;
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 100),
      child: ScaleAnimation(
        duration: Duration(milliseconds: 500),
        child: PenaltyItem(penalidades[index]),
      ),
    );
  }

  Widget _buildPenaltiesSummary(BuildContext context) {
    final penalidadesData = Provider.of<Penalidades>(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chip(
              side: BorderSide.none,
              avatar: CircleAvatar(
                backgroundColor: Colors.green.shade400,
                child: Text(
                  penalidadesData.totalOcorrencias.toString(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).textScaleFactor * 15,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                letterSpacing: .5,
              ),
              label: Text(
                'OCORRÊNCIAS',
              ),
              backgroundColor: Colors.green.shade900,
            ),
            Chip(
              side: BorderSide.none,
              avatar: CircleAvatar(
                backgroundColor: Colors.red.shade500,
                child: Text(
                  penalidadesData.totalAdvertencias.toString(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).textScaleFactor * 15,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                letterSpacing: .5,
              ),
              label: Text(
                'ADVERTÊNCIAS',
              ),
              backgroundColor: Colors.red.shade900,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  _buildPenaltiesSummary(context),
                  Expanded(
                    child: Consumer<Penalidades>(
                      builder: (context, penalidadesData, _) =>
                          ListView.separated(
                        itemCount: penalidadesData.itemsCount,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: _buildPenaltyItem,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
