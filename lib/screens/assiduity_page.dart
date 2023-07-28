import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_frequency.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/frequency_item.dart';
import 'package:provider/provider.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class AssiduityPage extends StatefulWidget {
  @override
  _AssiduityPageState createState() => _AssiduityPageState();
}

class _AssiduityPageState extends State<AssiduityPage> {
  bool _isLoading = true;

  Future<void> loadFrequencias(BuildContext context) async {
    await Provider.of<Frequencias>(context, listen: false)
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
                  FrequencyStatsWidget(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: frequenciasData.itemsCount,
                      itemBuilder: (ctx, i) {
                        return AnimationConfiguration.staggeredList(
                          position: i,
                          duration: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: FrequencyItem(frequencias[i]),
                            ),
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

class FrequencyStatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final frequenciasData = Provider.of<Frequencias>(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FrequencyChip(
                label: 'JUSTIFICADAS',
                count: frequenciasData.totalJustificada.toString(),
                backgroundColor: Colors.green.shade900,
              ),
              FrequencyChip(
                label: 'SEM JUSTIFICAR',
                count: frequenciasData.totalNaoJustificada.toString(),
                backgroundColor: Colors.red.shade900,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FrequencyChip extends StatelessWidget {
  final String label;
  final String count;
  final Color backgroundColor;

  const FrequencyChip({
    required this.label,
    required this.count,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      side: BorderSide.none,
      avatar: CircleAvatar(
        backgroundColor: backgroundColor,
        child: Text(
          count,
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
      label: Text(label),
      backgroundColor: backgroundColor,
    );
  }
}
