import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:projetocrescer/firebase_options.dart';
import 'package:projetocrescer/models/class_account.dart';
import 'package:projetocrescer/models/class_classroom.dart';
import 'package:projetocrescer/models/class_meal_schedule.dart';
import 'package:projetocrescer/models/class_notification.dart';
import 'package:projetocrescer/models/class_scheduling.dart';
import 'package:projetocrescer/models/class_announcement.dart';
import 'package:projetocrescer/models/class_frequency.dart';
import 'package:projetocrescer/models/class_penalties.dart';
import 'package:projetocrescer/models/class_pendencies.dart';
import 'package:projetocrescer/models/class_snack.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/preferences/network_services.dart';
import 'package:projetocrescer/routes/app_pages.dart';
import 'package:projetocrescer/theme/app_theme.dart';
import 'package:projetocrescer/utils/firebase_api.dart';
import 'package:provider/provider.dart';
import 'package:projetocrescer/screens/login_page.dart';
import 'package:projetocrescer/routes/app_route.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark));
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Login(),
        ),
        ChangeNotifierProvider(
          create: (_) => AgendamentosRefeicoes(),
        ),
        ChangeNotifierProvider(
          create: (_) => Penalidades(),
        ),
        ChangeNotifierProvider(
          create: (_) => Pendencias(),
        ),
        ChangeNotifierProvider(
          create: (_) => Frequencias(),
        ),
        ChangeNotifierProvider(
          create: (_) => AgendamentosAtendimentos(),
        ),
        ChangeNotifierProvider(
          create: (_) => Comunicados(),
        ),
        ChangeNotifierProvider(
          create: (_) => Perfis(),
        ),
        ChangeNotifierProvider(
          create: (_) => ListarAgendamentoRefeicao(),
        ),
        ChangeNotifierProvider(
          create: (_) => AulasDias(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        StreamProvider(
          create: (context) => NetworkService().controller.stream,
          initialData: NetworkStatus.online,
        ),
      ],
      child: GetMaterialApp(
        initialRoute: AppRoute.SPLASH,
        debugShowCheckedModeBanner: false,
        title: 'Projeto Crescer',
        theme: appThemeData,
        navigatorKey: navigatorKey,
        routes: AppRouter.getRoutes(),
      ),
    );
  }
}

class IndexPage extends StatefulWidget {
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
