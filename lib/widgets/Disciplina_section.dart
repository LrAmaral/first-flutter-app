import 'package:flutter/material.dart';

class DisciplinasSection extends StatelessWidget {
  const DisciplinasSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu_open, size: 100),
        Text(
          'Aqui estão suas disciplinas.',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
