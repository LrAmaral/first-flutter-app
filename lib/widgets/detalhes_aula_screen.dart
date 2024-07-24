import 'package:atividade/class/aulas.dart';
import 'package:atividade/widgets/future_buid_example.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetalhesAulaScreen extends StatelessWidget {
  final String codigo;

  const DetalhesAulaScreen({super.key, required this.codigo});

  @override
  Widget build(BuildContext context) {
    List<Aula> aulas = Aula.gerarAulas(codigo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Lista de Aulas $codigo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: aulas.length,
        itemBuilder: (context, index) {
          final aula = aulas[index];
          return ListTile(
            title: Text('Aula ${aula.data}'),
            subtitle: Text(aula.descricao),
            onTap: () {
              if (codigo == 'ALGD1' && aula.data == '14/08/09') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Aula10Screen(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class Aula10Screen extends StatelessWidget {
  const Aula10Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Aula 10'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FutureBuilderExample(),
                  ),
                );
              },
              child: const Text(
                'Exemplo de Future',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StreamBuilderExample(),
                  ),
                );
              },
              child: const Text(
                'Exemplo de Stream',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
