import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetocrescer/firebase_options.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/class_comunicado.dart';
import 'package:projetocrescer/models/class_frequencias.dart';
import 'package:projetocrescer/models/class_penalidades.dart';
import 'package:projetocrescer/models/class_pendencias.dart';
import 'package:projetocrescer/models/class_refeicao.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/preferences/network_services.dart';
import 'package:projetocrescer/screens/agendar_refeicao_page.dart';
import 'package:projetocrescer/screens/auth_or_home_page.dart';
import 'package:projetocrescer/screens/comunicado_detalhe_page.dart';
import 'package:projetocrescer/screens/comunicados_page.dart';
import 'package:projetocrescer/screens/fale_conosco_page.dart';
import 'package:projetocrescer/screens/horario_aluno_page.dart';
import 'package:projetocrescer/screens/listagem_agendamentos_coordenacao_page.dart';
import 'package:projetocrescer/screens/listagem_agendamentos_psicologo_page.dart';
import 'package:projetocrescer/screens/opcoes_agend_ref.dart';
import 'package:projetocrescer/screens/pendencias_page.dart';
import 'package:projetocrescer/screens/splash_screen.dart';
import 'package:projetocrescer/utils/custom_route.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/screens/agendar_psicologo_page.dart';
import 'package:projetocrescer/utils/firebase_api.dart';
import 'package:provider/provider.dart';
import 'package:projetocrescer/screens/agendar_coordenacao_page.dart';
import 'package:projetocrescer/screens/assiduidade_page.dart';
import 'package:projetocrescer/screens/home_page.dart';
import 'package:projetocrescer/screens/login_page.dart';
import 'package:projetocrescer/screens/penalidades_page.dart';
import 'package:projetocrescer/utils/app_route.dart';
import 'package:showcaseview/showcaseview.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
        StreamProvider(
          create: (context) => NetworkService().controller.stream,
          initialData: NetworkStatus.online,
        ),
      ],
      child: MaterialApp(
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
          AppRoute.COMUNICADOS: (ctx) => ComunicadosPage(),
          AppRoute.OPCOES_AGENDAMENTO: (ctx) => OpcoesAgendamento(),
          AppRoute.ASSIDUIDADE: (ctx) => AssiduidadePage(),
          AppRoute.PENALIDADES: (ctx) => PenalidadesPage(),
          AppRoute.AGENDAR_COORDENACAO: (ctx) => AgendarCoordenacaoPage(),
          AppRoute.AGENDAR_PSICOLOGO: (ctx) => AgendarPsicologoPage(),
          AppRoute.PENDENCIAS_PAGE: (ctx) => PendeciasPage(),
          AppRoute.LIST_AGENDAMENTOS_COORDENACAO: (ctx) =>
              ListagemAgendamentoCoordenacaoPage(),
          AppRoute.LIST_AGENDAMENTOS_PSICOLOGO: (ctx) =>
              ListagemAgendamentoPsicologoPage(),
          AppRoute.DETALHES_COMUNICADOS: (ctx) => ComunicadoDetalhePage(),
          AppRoute.FALE: (ctx) => ShowCaseWidget(
                builder: Builder(builder: (context) => FaleConosco()),
              ),
          AppRoute.AGENDAR_REF: (ctx) => AgendarRefeicao(),
          AppRoute.HORARIO_ALUNO: (ctx) => HorarioPage(),
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
