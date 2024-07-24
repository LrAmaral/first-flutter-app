import 'package:atividade/widgets/aula08.dart';
import 'package:atividade/widgets/detalhes_aula_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:atividade/widgets/welcome.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:atividade/user.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('userBox');
  runApp(const MyApp());
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Aula08(),
    ),
    GoRoute(
      path: '/welcome/:usuario',
      builder: (context, state) {
        final usuario = state.pathParameters['usuario'] ?? 'Usuário';
        return WelcomeScreen(usuario: usuario);
      },
    ),
    GoRoute(
      path: '/detalhes/:codigo',
      builder: (context, state) {
        final codigo = state.pathParameters['codigo']!;
        return DetalhesAulaScreen(codigo: codigo);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Minha Aplicação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
