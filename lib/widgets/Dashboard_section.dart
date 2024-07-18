import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({Key? key, required this.usuario}) : super(key: key);

  final String usuario;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.dashboard, size: 100),
        Text(
          'Bem-vindo ao Dashboard, $usuario!',
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
