import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:projetocrescer/firebase_options.dart';
import 'package:projetocrescer/models/class_account.dart';
import 'package:projetocrescer/models/class_scheduling.dart';
import 'package:projetocrescer/models/class_announcement.dart';
import 'package:projetocrescer/models/class_frequency.dart';
import 'package:projetocrescer/models/class_penalties.dart';
import 'package:projetocrescer/models/class_pendencies.dart';
import 'package:projetocrescer/models/class_snack.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/preferences/network_services.dart';
import 'package:projetocrescer/screens/account_page.dart';
import 'package:projetocrescer/screens/schedule_meal_page.dart';
import 'package:projetocrescer/screens/auth_or_home_page.dart';
import 'package:projetocrescer/screens/detail_notices_page.dart';
import 'package:projetocrescer/screens/notices_page.dart';
import 'package:projetocrescer/screens/contact_us_page.dart';
import 'package:projetocrescer/screens/student_schedule_page.dart';
import 'package:projetocrescer/screens/coordination_scheduling_list_page.dart';
import 'package:projetocrescer/screens/psychologist_scheduling_list_page.dart';
import 'package:projetocrescer/screens/scheduling_options.dart';
import 'package:projetocrescer/screens/pendencies_page.dart';
import 'package:projetocrescer/screens/splash_screen.dart';
import 'package:projetocrescer/utils/custom_route.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/screens/schedule_psychologist_page.dart';
import 'package:projetocrescer/utils/firebase_api.dart';
import 'package:provider/provider.dart';
import 'package:projetocrescer/screens/schedule_coordination_page.dart';
import 'package:projetocrescer/screens/assiduity_page.dart';
import 'package:projetocrescer/screens/home_page.dart';
import 'package:projetocrescer/screens/login_page.dart';
import 'package:projetocrescer/screens/penalties_page.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:showcaseview/showcaseview.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor:
        CustomColors.azul, // cor de fundo da barra de navegação
  ));
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
        StreamProvider(
          create: (context) => NetworkService().controller.stream,
          initialData: NetworkStatus.online,
        ),
      ],
      child: GetMaterialApp(
        initialRoute: AppRoute.SPLASH,
        debugShowCheckedModeBanner: false,
        title: 'Projeto Crescer',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ))),
          useMaterial3: true,
          primaryColor: CustomColors.azul,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: CustomColors.azul,
              fontFamily: 'Ubuntu',
              fontSize: 17,
            ),
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: CustomColors.azul),
            ),
          ),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: CustomColors.amarelo),
            centerTitle: true,
            backgroundColor: CustomColors.azul,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionsBuilder(),
            TargetPlatform.iOS: CustomPageTransitionsBuilder(),
          }),
        ),
        navigatorKey: navigatorKey,
        routes: {
          AppRoute.SPLASH: (ctx) => SplashScreen(),
          AppRoute.INDEX: (ctx) => AuthOrHomePage(),
          AppRoute.HOME: (ctx) => HomePage(),
          AppRoute.COMUNICADOS: (ctx) => NoticesPage(),
          AppRoute.OPCOES_AGENDAMENTO: (ctx) => SchedulingOptions(),
          AppRoute.ASSIDUIDADE: (ctx) => AssiduityPage(),
          AppRoute.PENALIDADES: (ctx) => PenaltiesPage(),
          AppRoute.AGENDAR_COORDENACAO: (ctx) => CoordinationSchedulePage(),
          AppRoute.AGENDAR_PSICOLOGO: (ctx) => PsychologistSchedulePage(),
          AppRoute.PENDENCIAS_PAGE: (ctx) => PendenciesPage(),
          AppRoute.LIST_AGENDAMENTOS_COORDENACAO: (ctx) =>
              CoordinationSchedulingPage(),
          AppRoute.LIST_AGENDAMENTOS_PSICOLOGO: (ctx) =>
              PsychologistSchedulingPage(),
          AppRoute.DETALHES_COMUNICADOS: (ctx) => DetailNoticesPage(),
          AppRoute.FALE: (ctx) => ShowCaseWidget(
                builder: Builder(builder: (context) => ContactUsPage()),
              ),
          AppRoute.AGENDAR_REF: (ctx) => MealPage(),
          AppRoute.HORARIO_ALUNO: (ctx) => StudentSchedulePage(),
          AppRoute.MEUS_DADOS: (ctx) => AccountPage(),
        },
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
