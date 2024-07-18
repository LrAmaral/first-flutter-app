import 'package:atividade/classes/login_details.dart';
import 'package:atividade/widgets/login_text_field.dart';
import 'package:atividade/widgets/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Aula08(title: 'Flutter Demo Home Page'),
        '/welcome': (context) => const WelcomeScreen(),
        '/logout': (context) => const LogoutScreen(),
      },
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

  void mudarTipoLogin(int idx) {
    setState(() {
      _loginController.text = '';
      _tipoCampoLogin = TiposLogin.values[idx];
      _tipoLogin = List<bool>.generate(3, (index) => index == idx);
    });
  }

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
    String login = _loginController.text;
    String senha = _senhaController.text;

    if (login.isEmpty || senha.isEmpty) {
      _showErrorDialog('Todos os campos são obrigatórios.');
      return false;
    }

    switch (_tipoCampoLogin) {
      case TiposLogin.email:
        if (!login.contains('@')) {
          _showErrorDialog('E-mail deve conter um "@"');
          return false;
        }
        break;
      case TiposLogin.cpf:
        if (login.length != 11 || int.tryParse(login) == null) {
          _showErrorDialog('CPF deve conter 11 dígitos.');
          return false;
        }
        break;
      case TiposLogin.telefone:
        if (login.length != 11 || int.tryParse(login) == null) {
          _showErrorDialog('Telefone deve conter 11 dígitos numéricos.');
          return false;
        }
        break;
    }
    return true;
  }

  void _login() {
    if (_validateFields()) {
      Navigator.pushNamed(context, '/welcome',
          arguments: {'usuario': _loginController.text});
    }
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
                  const SizedBox(width: 8),
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
              const SizedBox(height: 48),
              TextField(
                controller: _senhaController,
                obscureText: _esconderSenha,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _esconderSenha = !_esconderSenha;
                      });
                    },
                    icon: _esconderSenha
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
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
                  onPressed: _login,
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
