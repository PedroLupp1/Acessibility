import 'package:crob_project/pages/cadastro.dart';
import 'package:crob_project/pages/dados.dart';
import 'package:crob_project/pages/dashboard.dart';
import 'package:crob_project/pages/login.dart';
import 'package:crob_project/pages/splashscreen.dart';
import 'package:crob_project/pages_adm/dashboard_adm.dart';
import 'package:crob_project/pages_adm/material_upload.dart';
import 'package:crob_project/services/midia_service.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/login', 
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginCrob(),
    ),
    GoRoute(
      path: '/cadastro',
      builder: (context, state) => const Cadastro(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashBoard(),
    ),
    GoRoute(
      path: '/dashboardadm',
      builder: (context, state) => const DashBoardAdm(),
    ),
     GoRoute(path: '/dados',
    builder: (context, state) =>  const DadosCadastrais(),
    ),
     GoRoute(path: '/upload',
    builder: (context, state) =>  const Upload(),
    ),
  ],
);
