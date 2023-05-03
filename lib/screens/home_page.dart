import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/class_penalidades.dart';
import 'package:projetocrescer/models/class_pendencias.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/preferences/notification_services.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:projetocrescer/utils/custom_links.dart';
import 'package:projetocrescer/widgets/app_drawer.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/menu_home_page_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int itemsPendencias = 0;
  int itemsPenalidades = 0;
  int itemsCoordenacaoConfirmado = 0;
  int itemsPsicologoConfirmado = 0;

  CustomLinks links = CustomLinks();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationServices services = NotificationServices();

  //* QR CODE PARA AGENDAR REFEIÇÃO --------------------------------------------
  String qrCodeResult = "Aguardando...";

  bool resultInternet = false;
  String codeInvalido = "";
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //* QR CODE PARA AGENDAR REFEIÇÃO --------------------------------------------

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  void _updateStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        resultInternet = true;
      });
      updateText("3G/4G");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        resultInternet = true;
      });
      updateText("Conectado via wi-fi");
    } else {
      setState(() {
        resultInternet = false;
      });
      updateText("Atenção, você não tem uma conexão válida!");
    }
  }

  void updateText(String texto) {
    setState(() {});
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  //-------------------------------------------------

  Future<void> loadPendencias(BuildContext context) {
    return Provider.of<Pendencias>(context, listen: false)
        .loadPendencias(Provider.of<Login>(context, listen: false).matricula);
  }

  Future<void> loadPenalidades(BuildContext context) {
    return Provider.of<Penalidades>(context, listen: false)
        .loadPenalidades(Provider.of<Login>(context, listen: false).matricula);
  }

  Future<void> loadAgendamentos(BuildContext context) {
    return Provider.of<AgendamentosAtendimentos>(context, listen: false)
        .loadAgendamentos(Provider.of<Login>(context, listen: false).matricula);
  }

  //*--------------

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken();
  }

  Future onSelectNotificaton(payload) async {
    if (payload == 'comunicados') {
      await Navigator.of(context).pushNamed(AppRoute.COMUNICADOS);
    }
  }

//*--------------------
  @override
  void initState() {
    super.initState();
    services.requestPermission();
    var initilizationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var initializationSettings = InitializationSettings(
        android: initilizationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotificaton);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Map<String, dynamic> dataValue = message.data;
      String screen = dataValue['screen'].toString();
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: "@mipmap/ic_launcher",
              setAsGroupSummary: true,
              enableLights: true,
            ),
            iOS: IOSNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: screen,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      Map<String, dynamic> dataValue = message.data;
      String screen = dataValue['screen'].toString();
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: "@mipmap/ic_launcher",
              setAsGroupSummary: true,
              enableLights: true,
            ),
            iOS: IOSNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: screen,
        );
      }
    });

    _registerOnFirebase();

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateStatus);

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
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: CustomColors.fundo,
        appBar: AppBar(
          title: Text(
            'PROJETO CRESCER',
          ),
        ),
        drawer: AppDrawer(
          itemsPendencias > 0 ? itemsPendencias : 0,
          itemsPenalidades > 0 ? itemsPenalidades : 0,
          itemsCoordenacaoConfirmado > 0 ? itemsCoordenacaoConfirmado : 0,
          itemsPsicologoConfirmado > 0 ? itemsPsicologoConfirmado : 0,
        ),
        body: GridView.count(
          shrinkWrap: true,
          childAspectRatio: 1,
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          padding: EdgeInsets.all(12),
          children: [
            MenuHomePageScreen(
              title: 'COMUNICADOS',
              subTitle: 'Importantes',
              ontap: () {
                Navigator.of(context).pushNamed(AppRoute.COMUNICADOS);
              },
              imageUrl: 'images/comunicados.png',
            ),
            MenuHomePageScreen(
              title: 'CAFÉ/ALMOÇO',
              subTitle: 'Agende suas refeições',
              ontap: () async {
                await BarcodeScanner.scan().then((value) {
                  var jsonTEMP = jsonDecode(
                      utf8.decode(base64Url.decode(value.rawContent ?? '')));

                  print(jsonTEMP['matricula']);

                  if (jsonTEMP['matricula'] == null ||
                      jsonTEMP['nome'] == null ||
                      jsonTEMP['periodo'] == null ||
                      jsonTEMP['tipo'] == null) {
                    setState(() {
                      codeInvalido = "QR Code INVÁLIDO!";
                    });
                  } else {
                    setState(() {
                      codeInvalido = "";
                    });
                    Navigator.of(context).pushNamed(AppRoute.OPCOES_AGENDAMENTO,
                        arguments: value.rawContent);
                  }
                });
              },
              imageUrl: 'images/cafe.png',
            ),
            MenuHomePageScreen(
              title: 'FREQUÊNCIA',
              subTitle: 'Confira as faltas do(a) aluno(a)',
              ontap: () {
                Navigator.of(context).pushNamed(AppRoute.ASSIDUIDADE);
              },
              imageUrl: 'images/frequencia.png',
            ),
            MenuHomePageScreen(
              title: 'AULAS DO DIA',
              subTitle: 'Confira aulas do dia',
              ontap: () {},
              imageUrl: 'images/aulas.png',
            ),
            MenuHomePageScreen(
              title: 'HORÁRIO',
              subTitle: 'Confira o horário completo',
              ontap: () {},
              imageUrl: 'images/horarios.png',
            ),
            MenuHomePageScreen(
              title: 'PORTAL DO ALUNO',
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
                    right: MediaQuery.of(context).size.width * .13,
                    top: MediaQuery.of(context).size.width * .04,
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
                    right: MediaQuery.of(context).size.width * .13,
                    top: MediaQuery.of(context).size.width * .06,
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
            MenuHomePageScreen(
              title: 'REDES SOCIAIS',
              subTitle: 'Confira nossas redes sociais',
              ontap: () {
                Navigator.of(context).pushNamed(AppRoute.FALE);
              },
              imageUrl: 'images/redessociais.png',
            ),
          ],
        ),
      ),
    );
  }
}
