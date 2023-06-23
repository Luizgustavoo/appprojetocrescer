import 'dart:async';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/class_penalidades.dart';
import 'package:projetocrescer/models/class_pendencias.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/preferences/network_services.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/utils/custom_links.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/utils/hide_home.dart';
import 'package:projetocrescer/widgets/app_drawer.dart';
import 'package:projetocrescer/widgets/menu_home_page_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const route = '/home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int itemsPendencias = 0;
  int itemsPenalidades = 0;
  int itemsCoordenacaoConfirmado = 0;
  int itemsPsicologoConfirmado = 0;

  CustomLinks links = CustomLinks();

  //*---------LOAD REQUESTS----------------------------------------

  Future<void> loadPendencias(BuildContext context) {
    return Provider.of<Pendencias>(context, listen: false)
        .loadPendencias(Provider.of<Login>(context, listen: false).matricula!);
  }

  Future<void> loadPenalidades(BuildContext context) {
    return Provider.of<Penalidades>(context, listen: false)
        .loadPenalidades(Provider.of<Login>(context, listen: false).matricula!);
  }

  Future<void> loadAgendamentos(BuildContext context) {
    return Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .loadAgendamentos(
            Provider.of<Login>(context, listen: false).matricula!);
  }

  @override
  void initState() {
    super.initState();

    loadPenalidades(context).then((value) {
      itemsPenalidades =
          Provider.of<Penalidades>(context, listen: false).itemsCount;
    });
    loadPendencias(context).then((value) {
      setState(() {
        itemsPendencias =
            Provider.of<Pendencias>(context, listen: false).itemsCount;
      });
    });
    loadAgendamentos(context).then((value) {
      setState(() {
        itemsCoordenacaoConfirmado =
            Provider.of<AgendamentosAtendimentos>(context, listen: false)
                .itemsCountCoordenacaoConfirmado;
        itemsPsicologoConfirmado =
            Provider.of<AgendamentosAtendimentos>(context, listen: false)
                .itemsCountPsicologoConfirmado;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'SAIR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                color: CustomColors.azul,
              ),
            ),
            content: Text(
              'Deseja realmente sair do aplicativo?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Ubuntu',
              ),
            ),
            actions: [
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.azul,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text(
                    'NÃO',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.azul,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text(
                    'SIM',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: CustomColors.fundo,
        appBar: AppBar(
          title: Text(
            'PROJETO CRESCER',
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: AppDrawer(
          itemsPendencias > 0 ? itemsPendencias : 0,
          itemsPenalidades > 0 ? itemsPenalidades : 0,
          itemsCoordenacaoConfirmado > 0 ? itemsCoordenacaoConfirmado : 0,
          itemsPsicologoConfirmado > 0 ? itemsPsicologoConfirmado : 0,
        ),
        body: networkStatus == NetworkStatus.online
            ? Column(
                children: [
                  Container(child: BannerWidget()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Divider(
                          color: CustomColors.azul,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, bottom: 5),
                        child: Text(
                          'Categorias',
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: BodyHome(
                        links: links,
                        itemsPendencias: itemsPendencias,
                        itemsPenalidades: itemsPenalidades),
                  )
                ],
              )
            : HideHome(),
      ),
    );
  }
}

class BannerWidget extends StatefulWidget {
  BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  List<BannerModel> listBanners = [
    BannerModel(
        imagePath:
            'https://casadobommeninodearapongas.org/images/noticias/projeto_crescer_realiza_a_doacao_de_19_computadores_para_seus_alunos_1685713621.jpeg',
        id: '1'),
    BannerModel(
        imagePath:
            'https://casadobommeninodearapongas.org/images/noticias/projeto_crescer_promove_com_sucesso_o_ultimo_encontro_do_curso_de_chocolate_1686171479.jpeg',
        id: '2'),
    BannerModel(
        imagePath:
            'https://casadobommeninodearapongas.org/images/noticias/projeto_crescer_realiza_com_sucesso_o_dia_do_desafio_1685624728.jpeg',
        id: '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        BannerCarousel.fullScreen(
          activeColor: CustomColors.azul,
          disableColor: Colors.grey.shade500,
          animation: true,
          height: 200,
          banners: listBanners,
        ),
        Positioned(
          left: 10,
          bottom: 30,
          child: Container(
            width: 220,
            color: Colors.blue.shade900.withAlpha(220),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(
              'EVENTO: 26/06/2023',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class BodyHome extends StatelessWidget {
  const BodyHome({
    Key? key,
    required this.links,
    required this.itemsPendencias,
    required this.itemsPenalidades,
  }) : super(key: key);

  final CustomLinks links;
  final int itemsPendencias;
  final int itemsPenalidades;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 10),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: 1,
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        padding: EdgeInsets.all(8),
        children: [
          MenuHomePageScreen(
            title: 'COMUNICADOS',
            subTitle: 'Importantes',
            ontap: () {
              Navigator.pushNamed(context, AppRoute.COMUNICADOS);
            },
            imageUrl: 'images/comunicados.png',
          ),
          MenuHomePageScreen(
              title: 'CAFÉ/ALMOÇO',
              subTitle: 'Agende suas refeições',
              imageUrl: 'images/cafe.png',
              ontap: () {
                Navigator.pushNamed(context, AppRoute.AGENDAR_REF);
              }),
          MenuHomePageScreen(
            title: 'FREQUÊNCIA',
            subTitle: 'Confira as faltas do(a) aluno(a)',
            ontap: () {
              Navigator.of(context).pushNamed(AppRoute.ASSIDUIDADE);
            },
            imageUrl: 'images/frequencia.png',
          ),
          MenuHomePageScreen(
            title: 'HORÁRIO',
            subTitle: 'Confira o horário completo',
            ontap: () {
              Navigator.of(context).pushNamed(AppRoute.HORARIO_ALUNO);
            },
            imageUrl: 'images/horarios.png',
          ),
          MenuHomePageScreen(
            title: 'PORTAL ALUNO',
            subTitle: 'Acesse seu portal \ndo aluno',
            ontap: () async {
              await links.entrarPortal();
            },
            imageUrl: 'images/portal.png',
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              MenuHomePageScreen(
                title: 'PENDÊNCIAS',
                subTitle: 'Confira as pendências \nem nossos registros',
                ontap: () {
                  Navigator.of(context).pushNamed(AppRoute.PENDENCIAS_PAGE);
                },
                imageUrl: 'images/pendencia.png',
              ),
              if (itemsPendencias > 0)
                Positioned(
                  right: MediaQuery.of(context).size.width * .09,
                  top: MediaQuery.of(context).size.width * .04,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.error),
                    constraints: BoxConstraints(
                      minHeight: 5,
                      minWidth: 22,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      itemsPendencias.toString(),
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
            alignment: Alignment.center,
            children: [
              MenuHomePageScreen(
                title: 'PENALIDADES',
                subTitle: 'Confira as penalidades',
                ontap: () {
                  Navigator.of(context).pushNamed(AppRoute.PENALIDADES);
                },
                imageUrl: 'images/penalidades.png',
              ),
              if (itemsPenalidades > 0)
                Positioned(
                  right: MediaQuery.of(context).size.width * .09,
                  top: MediaQuery.of(context).size.width * .06,
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
                      itemsPenalidades.toString(),
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
          MenuHomePageScreen(
            title: 'FALE CONOSCO',
            subTitle: 'Confira nossos canais \nde atendimento',
            ontap: () {
              Navigator.of(context).pushNamed(AppRoute.FALE);
            },
            imageUrl: 'images/faleconosco.png',
          ),
        ],
      ),
    );
  }
}
