import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({super.key, required this.usuario});

  final String usuario;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.dashboard, size: 100),
        Text(
          'Bem-vindo, $usuario!',
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
