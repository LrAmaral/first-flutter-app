import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:atividade/class/login_details.dart';
import 'package:atividade/widgets/login_text_field.dart';
import 'package:atividade/widgets/welcome.dart';

void main() {
  runApp(const MyApp());
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Aula08(title: 'Atividade'),
    ),
    GoRoute(
      path: '/welcome/:usuario',
      builder: (context, state) {
        final usuario = state.pathParameters['usuario'] ?? 'Usuário';
        return WelcomeScreen(usuario: usuario);
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

class Aula08 extends StatefulWidget {
  const Aula08({super.key, required this.title});

  final String title;

  @override
  State<Aula08> createState() => _Aula08State();
}

class _Aula08State extends State<Aula08> {
  late final TextEditingController _loginController;
  late final TextEditingController _senhaController;
  var _tipoCampoLogin = TiposLogin.email;
  var _esconderSenha = true;
  var _tipoLogin = [true, false, false];

  @override
  void initState() {
    _loginController = TextEditingController();
    _senhaController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  bool _validateFields() {
    String login = _loginController.text.trim();
    String senha = _senhaController.text.trim();

    if (login.isEmpty || senha.isEmpty) {
      _showErrorDialog('Todos os campos são obrigatórios.');
      return false;
    }

    if (senha != 'admin') {
      _showErrorDialog('Senha incorreta.');
      return false;
    }

    switch (_tipoCampoLogin) {
      case TiposLogin.email:
        if (!login.contains('@')) {
          _showErrorDialog('E-mail deve conter um "@"');
          return false;
        } else if (login.split('@').length != 2) {
          _showErrorDialog('E-mail deve conter exatamente um "@"');
          return false;
        }
        break;
      case TiposLogin.cpf:
        if (login.length != 11 || int.tryParse(login) == null) {
          _showErrorDialog('CPF deve conter 11 dígitos numéricos.');
          return false;
        }
        break;
      case TiposLogin.telefone:
        if (login.length != 10 && login.length != 11) {
          _showErrorDialog('Telefone deve conter 10 ou 11 dígitos numéricos.');
          return false;
        }

        if (int.tryParse(login) == null) {
          _showErrorDialog('Telefone deve conter apenas dígitos numéricos.');
          return false;
        }
        break;
    }

    return true;
  }

  void _login(BuildContext context) {
    if (_validateFields()) {
      context.go('/welcome/Lucas');
    }
  }

  void mudarTipoLogin(int idx) {
    setState(() {
      _loginController.text = '';
      _tipoCampoLogin = TiposLogin.values[idx];
      _tipoLogin = List<bool>.generate(3, (index) => index == idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                width: 150,
                image: AssetImage('assets/images/logo.png'),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Logar com'),
                  const SizedBox(width: 4),
                  ToggleButtons(
                    isSelected: _tipoLogin,
                    onPressed: (int idx) {
                      mudarTipoLogin(idx);
                    },
                    fillColor: Colors.blue.withOpacity(0.2),
                    selectedColor: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Email'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('CPF'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Telefone'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 48),
              LoginTextField(
                controller: _loginController,
                tipoLogin: _tipoCampoLogin,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _senhaController,
                obscureText: _esconderSenha,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _esconderSenha = !_esconderSenha;
                      });
                    },
                    icon: _esconderSenha
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.blue,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.blue,
                          ),
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
