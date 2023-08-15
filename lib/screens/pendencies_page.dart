import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_pendencies.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/widgets/pendencies_item.dart';
import 'package:projetocrescer/widgets/show_case.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class PendenciesPage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING_PENDENCIES";
  @override
  _PendenciesPageState createState() => _PendenciesPageState();
}

class _PendenciesPageState extends State<PendenciesPage> {
  final GlobalKey globalKeyTwelve = GlobalKey();
  bool _isLoading = true;

  Future<void> loadPendencias(BuildContext context) async {
    final matricula = Provider.of<Login>(context, listen: false).matricula;
    if (matricula != null) {
      await Provider.of<Pendencias>(context, listen: false)
          .loadPendencias(matricula);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(PendenciesPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          PendenciesPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result) ShowCaseWidget.of(context).startShowCase([globalKeyTwelve]);
      });
    });
    super.initState();
    loadPendencias(context);
  }

  Widget _buildPendencyItem(BuildContext context, int index) {
    final pendenciasData = Provider.of<Pendencias>(context);
    final pendencias = pendenciasData.items;
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 100),
      child: ScaleAnimation(
        duration: Duration(milliseconds: 500),
        child: PendenciesItem(pendencias[index]),
      ),
    );
  }

  Widget _buildPendenciesList(BuildContext context) {
    return Expanded(
      child: Consumer<Pendencias>(
        builder: (context, pendenciasData, _) => pendenciasData.itemsCount <= 0
            ? Center(
                child: Text(
                  'Nenhuma pendência encontrada! \nParabéns. 💙',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              )
            : ListView.builder(
                itemCount: pendenciasData.itemsCount,
                itemBuilder: (ctx, i) => _buildPendencyItem(context, i),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowCaseView(
            globalKey: globalKeyTwelve,
            title: 'PENDÊNCIAS DO ALUNO(A)',
            description:
                'Visualize e resolva as pendências do aluno de forma organizada. Verifique chaves, uniforme, figurino e livros. Mantenha o contato com a equipe escolar para solucionar as questões. Sua colaboração é essencial para o sucesso acadêmico e o bom funcionamento da instituição. Agradecemos sua atenção e cooperação!',
            border: CircleBorder(),
            child: Text('PENDÊNCIAS DO ALUNO(A)')),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => loadPendencias(context),
              child: Column(
                children: [
                  _buildPendenciesList(context),
                ],
              ),
            ),
    );
  }
}
