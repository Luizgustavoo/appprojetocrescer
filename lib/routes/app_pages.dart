import 'package:flutter/material.dart';
import 'package:projetocrescer/routes/app_route.dart';
import 'package:projetocrescer/screens/account_page.dart';
import 'package:projetocrescer/screens/alert_page.dart';
import 'package:projetocrescer/screens/assiduity_page.dart';
import 'package:projetocrescer/screens/auth_or_home_page.dart';
import 'package:projetocrescer/screens/badge_page.dart';
import 'package:projetocrescer/screens/contact_us_page.dart';
import 'package:projetocrescer/screens/coordination_scheduling_list_page.dart';
import 'package:projetocrescer/screens/detail_notices_page.dart';
import 'package:projetocrescer/screens/home_page.dart';
import 'package:projetocrescer/screens/notices_page.dart';
import 'package:projetocrescer/screens/penalties_page.dart';
import 'package:projetocrescer/screens/pendencies_page.dart';
import 'package:projetocrescer/screens/psychologist_scheduling_list_page.dart';
import 'package:projetocrescer/screens/schedule_coordination_page.dart';
import 'package:projetocrescer/screens/schedule_meal_page.dart';
import 'package:projetocrescer/screens/schedule_psychologist_page.dart';
import 'package:projetocrescer/screens/scheduling_options.dart';
import 'package:projetocrescer/screens/splash_screen.dart';
import 'package:projetocrescer/screens/student_schedule_page.dart';
import 'package:showcaseview/showcaseview.dart';

class AppRouter {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoute.SPLASH: (ctx) => SplashScreen(),
      AppRoute.INDEX: (ctx) => AuthOrHomePage(),
      AppRoute.HOME: (ctx) => HomePage(),
      AppRoute.COMUNICADOS: (ctx) => ShowCaseWidget(
              builder: Builder(
            builder: (context) => NoticesPage(),
          )),
      AppRoute.OPCOES_AGENDAMENTO: (ctx) => SchedulingOptions(),
      AppRoute.ASSIDUIDADE: (ctx) => ShowCaseWidget(
              builder: Builder(
            builder: (context) => AssiduityPage(),
          )),
      AppRoute.PENALIDADES: (ctx) => ShowCaseWidget(
              builder: Builder(
            builder: (context) => PenaltiesPage(),
          )),
      AppRoute.AGENDAR_COORDENACAO: (ctx) => CoordinationSchedulePage(),
      AppRoute.AGENDAR_PSICOLOGO: (ctx) => PsychologistSchedulePage(),
      AppRoute.PENDENCIAS_PAGE: (ctx) => ShowCaseWidget(
              builder: Builder(
            builder: (context) => PendenciesPage(),
          )),
      AppRoute.LIST_AGENDAMENTOS_COORDENACAO: (ctx) => ShowCaseWidget(
              builder: Builder(
            builder: (context) => CoordinationSchedulingPage(),
          )),
      AppRoute.LIST_AGENDAMENTOS_PSICOLOGO: (ctx) => ShowCaseWidget(
              builder: Builder(
            builder: (context) => PsychologistSchedulingPage(),
          )),
      AppRoute.DETALHES_COMUNICADOS: (ctx) => DetailNoticesPage(),
      AppRoute.FALE: (ctx) => ShowCaseWidget(
            builder: Builder(
              builder: (context) => ContactUsPage(),
            ),
          ),
      AppRoute.AGENDAR_REF: (ctx) => ShowCaseWidget(
              builder: Builder(
            builder: (context) => MealPage(),
          )),
      AppRoute.HORARIO_ALUNO: (ctx) => StudentSchedulePage(),
      AppRoute.MEUS_DADOS: (ctx) => ShowCaseWidget(
            builder: Builder(
              builder: (context) => AccountPage(),
            ),
          ),
      AppRoute.NOTIFICACAO: (ctx) => NotificationsScreen(),
      AppRoute.CRACHA: (ctx) => ShowCaseWidget(
              builder: Builder(
            builder: (context) => BadgePage(),
          )),
    };
  }
}
