import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/preferences/network_services.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/utils/constants.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/utils/custom_links.dart';
import 'package:projetocrescer/widgets/custom_list_tile.dart';
import 'package:projetocrescer/widgets/hide_drawer.dart';
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
    var networkStatus = Provider.of<NetworkStatus>(context);
    CustomLinks links = CustomLinks();

    var providerFoto = Provider.of<Login>(context).foto.toString();

    bool fotoExiste = false;

    final String foto = Constants.URL_FOTOS + providerFoto;

    if (providerFoto != 'null') {
      fotoExiste = true;
    }

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: size.width * 0.80,
        height: size.height,
        child: networkStatus == NetworkStatus.online
            ? Drawer(
                child: ListView(
                  children: [
                    Container(
                      height: size.height * .3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            CustomColors.azul,
                            Colors.blue.shade500,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: BackdropFilter(
                        filter:
                            new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: DrawerHeader(
                          duration: Duration(milliseconds: 200),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: CustomColors.amarelo,
                                    elevation: 3,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(60),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CircleAvatar(
                                        radius: size.width * .15,
                                        backgroundImage: fotoExiste
                                            ? NetworkImage(
                                                foto,
                                              )
                                            : AssetImage('images/avatar.png')
                                                as ImageProvider,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        Provider.of<Login>(context)
                                                .usuarioMatricula
                                                .toString() +
                                            ' | ' +
                                            Provider.of<Login>(context)
                                                .serie
                                                .toString() +
                                            'º ANO',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 3.0,
                                              color: Colors.black,
                                            ),
                                            Shadow(
                                              offset: Offset(3.0, 3.0),
                                              blurRadius: 8.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ],
                                          fontFamily: 'Montserrat',
                                          overflow: TextOverflow.clip,
                                          color: CustomColors.amarelo,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    CustomListTile(Icons.home_rounded, 'INÍCIO', () {
                      Navigator.of(context).pushNamed(AppRoute.HOME);
                    }, true),
                    CustomListTile(
                        FontAwesomeIcons.bell, 'ALERTAS', () {}, true),
                    CustomListTile(
                        Icons.people_alt_rounded, 'MEUS DADOS', () {}, true),
                    Stack(
                      children: [
                        CustomListTile(
                            Icons.pending_actions_rounded, 'AG. PSICÓLOGO', () {
                          Navigator.of(context)
                              .pushNamed(AppRoute.LIST_AGENDAMENTOS_PSICOLOGO);
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
                        CustomListTile(
                            Icons.pending_actions_rounded, 'AG. COORDENAÇÃO',
                            () {
                          Navigator.of(context).pushNamed(
                              AppRoute.LIST_AGENDAMENTOS_COORDENACAO);
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
                                totalAgendamentoCoordenacaoConfirmado
                                    .toString(),
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
                    CustomListTile(Icons.message_rounded, 'COMUNICADOS', () {
                      Navigator.pushNamed(context, AppRoute.COMUNICADOS);
                    }, true),
                    CustomListTile(
                        Icons.credit_card_rounded, 'CRACHÁ', () {}, true),
                    CustomListTile(
                        Icons.category_rounded, 'OFICINAS/NÍVEIS', () {}, true),
                    Stack(
                      children: [
                        CustomListTile(
                            Icons.pending_actions_rounded, 'PENDÊNCIAS', () {
                          Navigator.of(context)
                              .pushNamed(AppRoute.PENDENCIAS_PAGE);
                        }, true),
                        if (totalPendencias > 0)
                          Positioned(
                            right: 130,
                            top: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).colorScheme.error),
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
                    // CustomListTile(Icons.rule_rounded, 'FALTAS EM REUNIOES', () {}, true),
                    Stack(
                      children: [
                        CustomListTile(Icons.warning_rounded, 'PENALIDADES',
                            () {
                          Navigator.of(context).pushNamed(AppRoute.PENALIDADES);
                        }, true),
                        if (totalPennalidades > 0)
                          Positioned(
                            right: 120,
                            top: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).colorScheme.error),
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
                    CustomListTile(Icons.phone_in_talk_rounded, 'FALE CONOSCO',
                        () {
                      Navigator.of(context).pushReplacementNamed(
                        AppRoute.FALE,
                      );
                    }, false),
                    CustomListTile(Icons.exit_to_app_rounded, 'SAIR', () {
                      Provider.of<Login>(context, listen: false).logout;

                      Navigator.of(context).pushReplacementNamed(
                        AppRoute.INDEX,
                      );
                    }, false),

                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 3),
                      child: Column(
                        children: [
                          Text(
                            'Redes Sociais - Projeto Crescer',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              links.instagram();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.instagram,
                              color: Colors.purple,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              links.facebook();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              links.tiktok();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.tiktok,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              links.youtube();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.youtube,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : ShimmerDrawer(),
      ),
    );
  }
}
