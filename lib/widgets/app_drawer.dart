import 'package:flutter/material.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/widgets/custom_colors.dart';
import 'package:projetocrescer/widgets/custom_list_tile.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final int totalPendencias;
  final int totalPennalidades;
  final int totalAgendamentoCoordenacaoConfirmado;
  final int totalAgendamentoPsicologoConfirmado;

  AppDrawer(
      this.totalPendencias,
      this.totalPennalidades,
      this.totalAgendamentoCoordenacaoConfirmado,
      this.totalAgendamentoPsicologoConfirmado);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'images/logo.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                            Provider.of<Login>(context)
                                .usuarioMatricula
                                .toString(),
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              overflow: TextOverflow.ellipsis,
                              color: AppColor.corTitulo,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColors.azul,
                  Colors.blue[500],
                ],
              ),
            ),
          ),
          CustomListTile(Icons.home_rounded, 'INÍCIO', () {
            Navigator.of(context).pushNamed(AppRoute.HOME);
          }, true),
          CustomListTile(
              Icons.fastfood_rounded, 'AGENDAR CAFÉ/ALMOÇO', () {}, true),
          Stack(
            children: [
              CustomListTile(Icons.pending_actions_rounded, 'AG. PSICÓLOGO',
                  () {
                Navigator.of(context).pushNamed(AppRoute.LIST_AGENDAMENTOS);
              }, true),
              if (totalAgendamentoPsicologoConfirmado > 0)
                Positioned(
                  right: 110,
                  top: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green),
                    constraints: BoxConstraints(
                      minHeight: 5,
                      minWidth: 22,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      totalAgendamentoPsicologoConfirmado.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Stack(
            children: [
              CustomListTile(Icons.pending_actions_rounded, 'AG. COORDENAÇÃO',
                  () {
                Navigator.of(context).pushNamed(AppRoute.LIST_AGENDAMENTOS);
              }, true),
              if (totalAgendamentoCoordenacaoConfirmado > 0)
                Positioned(
                  right: 80,
                  top: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green),
                    constraints: BoxConstraints(
                      minHeight: 5,
                      minWidth: 22,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      totalAgendamentoCoordenacaoConfirmado.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          CustomListTile(Icons.percent_rounded, 'ASSIDUIDADE', () {
            Navigator.of(context).pushNamed(AppRoute.ASSIDUIDADE);
          }, true),
          CustomListTile(Icons.message_rounded, 'COMUNICADOS', () {}, true),
          CustomListTile(Icons.credit_card_rounded, 'CRACHÁ', () {}, true),
          CustomListTile(Icons.paste_rounded, 'FICHA DO ALUNO', () {}, true),
          CustomListTile(Icons.people_alt_rounded, 'MEUS DADOS', () {}, true),
          CustomListTile(Icons.category_rounded, 'OFICINAS', () {}, true),
          CustomListTile(
              Icons.auto_stories_rounded, 'MATERIAL DA AULA', () {}, true),
          Stack(
            children: [
              CustomListTile(Icons.pending_actions_rounded, 'PENDÊNCIAS', () {
                Navigator.of(context).pushNamed(AppRoute.PENDENCIAS_PAGE);
              }, true),
              if (totalPendencias > 0)
                Positioned(
                  right: 130,
                  top: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).errorColor),
                    constraints: BoxConstraints(
                      minHeight: 5,
                      minWidth: 22,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      totalPendencias.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          CustomListTile(Icons.rule_rounded, 'FALTAS EM REUNIOES', () {}, true),
          Stack(
            children: [
              CustomListTile(Icons.warning_rounded, 'PENALIDADES', () {
                Navigator.of(context).pushNamed(AppRoute.PENALIDADES);
              }, true),
              if (totalPennalidades > 0)
                Positioned(
                  right: 120,
                  top: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).errorColor),
                    constraints: BoxConstraints(
                      minHeight: 5,
                      minWidth: 22,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      totalPennalidades.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          CustomListTile(Icons.exit_to_app_rounded, 'SAIR', () {
            Provider.of<Login>(context, listen: false).logout;

            Navigator.of(context).pushReplacementNamed(
              AppRoute.INDEX,
            );
          }, false),
        ],
      ),
    );
  }
}
