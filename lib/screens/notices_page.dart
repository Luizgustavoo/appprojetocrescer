import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_announcement.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/notices_item.dart';
import 'package:projetocrescer/widgets/show_case.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class NoticesPage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING_NOTICES";
  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  final GlobalKey globalKeyTen = GlobalKey();
  final GlobalKey globalKeyEleven = GlobalKey();
  bool _isLoading = true;

  Future<void> loadComunicados(BuildContext context) async {
    final matricula = Provider.of<Login>(context, listen: false).matricula;
    if (matricula != null) {
      await Provider.of<Comunicados>(context, listen: false)
          .loadComunicados(matricula);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(NoticesPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          NoticesPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result)
          ShowCaseWidget.of(context)
              .startShowCase([globalKeyTen, globalKeyEleven]);
      });
    });
    super.initState();
    loadComunicados(context);
  }

  Widget _buildNoticesItem(BuildContext context, int index) {
    final comunicadosData = Provider.of<Comunicados>(context);
    final comunicados = comunicadosData.items;
    return NoticesItem(comunicados[index]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.fundo,
      appBar: AppBar(
        title: ShowCaseView(
            globalKey: globalKeyTen,
            title: 'COMUNICADOS',
            description:
                'Fique atualizado(a) com informações importantes da escola e ensino dos filhos. Receba comunicados gerais e por turma e alertas urgentes. Participe ativamente da vida acadêmica do seu filho(a). Comunicação transparente para o melhor aprendizado e experiência escolar. Agradecemos sua parceria!',
            border: CircleBorder(),
            child: Text('COMUNICADOS')),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              color: CustomColors.amarelo,
              onRefresh: () => loadComunicados(context),
              child: Consumer<Comunicados>(
                builder: (context, comunicadosData, _) => Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: comunicadosData.itemsCount,
                        itemBuilder: _buildNoticesItem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
