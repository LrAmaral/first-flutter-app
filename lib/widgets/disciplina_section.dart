import 'package:atividade/class/disciplina.dart';
import 'package:atividade/widgets/disciplina.dart';
import 'package:flutter/material.dart';

class DisciplinasSection extends StatelessWidget {
  const DisciplinasSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Disciplina> disciplinas = Disciplina.gerarDisciplinas();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Disciplinas',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        itemCount: disciplinas.length,
        itemBuilder: (context, index) {
          return DisciplinaCard(disciplina: disciplinas[index]);
        },
      ),
    );
  }
}
