import 'package:flutter/material.dart';
import 'package:atividade/class/disciplina.dart'; 

class DisciplinasSection extends StatelessWidget {
  const DisciplinasSection({super.key});  

  @override
  Widget build(BuildContext context) {
    List<Disciplina> disciplinas = Disciplina.gerarDisciplinas();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
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

class DisciplinaCard extends StatelessWidget {
  final Disciplina disciplina;

  const DisciplinaCard({super.key, required this.disciplina});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Center(
                child: Text(disciplina.codigo),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(disciplina.nome),
                Text(disciplina.professor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
