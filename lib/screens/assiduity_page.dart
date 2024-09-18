import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_frequency.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/frequency_item.dart';
import 'package:projetocrescer/widgets/show_case.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class AssiduityPage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING_ASSIDUITY";
  @override
  _AssiduityPageState createState() => _AssiduityPageState();
}

class _AssiduityPageState extends State<AssiduityPage> {
  bool _isLoading = true;
  final GlobalKey globalKeySix = GlobalKey();

  Future<void> loadFrequencias(BuildContext context) async {
    await Provider.of<Frequencias>(context, listen: false)
        .loadFrequencias(Provider.of<Login>(context, listen: false).matricula!)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(AssiduityPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          AssiduityPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result) ShowCaseWidget.of(context).startShowCase([globalKeySix]);
      });
    });
    super.initState();
    loadFrequencias(context);
  }

  Widget build(BuildContext context) {
    final frequenciasData = Provider.of<Frequencias>(context);
    final frequencias = frequenciasData.items;

    return Scaffold(
      appBar: AppBar(
        title: ShowCaseView(
            globalKey: globalKeySix,
            title: 'FREQUÊNCIAS DO(A) ALUNO(A)',
            description:
                'Visualize a frequência e faltas do aluno de forma detalhada. Veja as faltas justificadas e não justificadas. Acesse o histórico completo de frequência. Justifique faltas não justificadas e obtenha suporte da equipe escolar. Garanta o sucesso acadêmico do aluno com sua participação ativa.',
            border: CircleBorder(),
            child: Text('FREQUÊNCIAS DO(A) ALUNO(A)')),
      ),
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
              // fontSize: MediaQuery.of(context).textScaleFactor * 15,
              fontFamily: 'Montserrat',
              color: Colors.white),
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.white,
        // fontSize: MediaQuery.of(context).textScaleFactor * 15,
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.bold,
        letterSpacing: .5,
      ),
      label: Text(label),
      backgroundColor: backgroundColor,
    );
  }
}
