import 'dart:math';
import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  DashboardSection({super.key, required this.usuario});

  final String usuario;

  final List<String> _disciplinas = [
    'Algoritmos e Programação',
    'Estrutura de Dados I',
    'Banco de Dados I',
    'Estrutura de Dados II',
    'Programação Web',
    'Banco de Dados II',
    'Técnicas de Programação II',
    'Programação para Dispositivos Móveis',
  ];

  String _sugestaoDisciplina() {
    final random = Random();
    return _disciplinas[random.nextInt(_disciplinas.length)];
  }

  @override
  Widget build(BuildContext context) {
    String sugestao = _sugestaoDisciplina();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.dashboard, size: 100),
        Text(
          'Bem-vindo, $usuario!',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        const Text(
          'Sugestão de disciplina para estudar:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Text(
          sugestao,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
