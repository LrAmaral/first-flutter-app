import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: const Text('Logout'),
          content: const Text('Você saiu com sucesso!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                context.go('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
