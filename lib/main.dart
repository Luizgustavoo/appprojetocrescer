import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_agendamento.dart';
import 'package:projetocrescer/models/class_comunicado.dart';
import 'package:projetocrescer/models/class_frequencias.dart';
import 'package:projetocrescer/models/class_horarios_atendimento.dart';
import 'package:projetocrescer/models/class_penalidades.dart';
import 'package:projetocrescer/models/class_pendencias.dart';
import 'package:projetocrescer/models/class_refeicao.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/screens/auth_or_home_page.dart';
import 'package:projetocrescer/screens/comunicado_detalhe_page.dart';
import 'package:projetocrescer/screens/comunicados_page.dart';
import 'package:projetocrescer/screens/calendar.dart';
import 'package:projetocrescer/screens/listagem_agendamentos_page.dart';
import 'package:projetocrescer/screens/opcoes_agend.dart';
import 'package:projetocrescer/screens/pendencias_page.dart';
import 'package:projetocrescer/screens/splash_screen.dart';
import 'package:projetocrescer/utils/custom_route.dart';
import 'package:provider/provider.dart';
import 'package:projetocrescer/screens/agendar_coordenacao_page.dart';
import 'package:projetocrescer/screens/assiduidade_page.dart';
import 'package:projetocrescer/screens/home_page.dart';
import 'package:projetocrescer/screens/login_page.dart';
import 'package:projetocrescer/screens/penalidades_page.dart';
import 'package:projetocrescer/utils/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Login(),
        ),
        ChangeNotifierProvider(
          create: (_) => AgendamentosRefeicoes(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Penalidades(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Pendencias(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Frequencias(),
        ),
        ChangeNotifierProvider(
          create: (_) => new AgendamentosAtendimentos(),
        ),
        ChangeNotifierProvider(
          create: (_) => new HorariosAtendimentos(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Comunicados(),
        ),
      ],
      child: MaterialApp(
        initialRoute: AppRoute.SPLASH,
        debugShowCheckedModeBanner: false,
        title: 'Projeto Crescer ',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionsBuilder(),
            TargetPlatform.iOS: CustomPageTransitionsBuilder(),
          }),
        ),
        routes: {
          AppRoute.SPLASH: (ctx) => SplashScreen(),
          AppRoute.INDEX: (ctx) => AuthOrHomePage(),
          AppRoute.HOME: (ctx) => HomePage(),
          AppRoute.OPCOES_AGENDAMENTO: (ctx) => OpcoesAgendamento(),
          AppRoute.PENALIDADES: (ctx) => PenalidadesPage(),
          AppRoute.ASSIDUIDADE: (ctx) => AssiduidadePage(),
          AppRoute.AGENDAR_COORDENACAO: (ctx) => AgendarCoordenacaoPage(),
          AppRoute.PENDENCIAS_PAGE: (ctx) => PendecniasPage(),
          AppRoute.LIST_AGENDAMENTOS: (ctx) => ListagemAgendamentoPage(),
          AppRoute.COMUNICADOS: (ctx) => ComunicadosPage(),
          AppRoute.DETALHES_COMUNICADOS: (ctx) => ComunicadoDetalhePage(),
          AppRoute.EVENTOS: (ctx) => TableEventsExample(),
        },
      ),
    );
  }
}

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
