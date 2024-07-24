import 'package:atividade/class/login_details.dart';
import 'package:atividade/user.dart';
import 'package:atividade/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

// Classe StatefulWidget
class Aula08 extends StatefulWidget {
  const Aula08({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Aula08State createState() => _Aula08State();
}

// Classe State correspondente
class _Aula08State extends State<Aula08> {
  late final TextEditingController _loginController;
  late final TextEditingController _senhaController;
  bool _manterConectado =
      false; // Adicionado para controlar a opção de manter-se conectado
  var _tipoCampoLogin = TiposLogin.email;
  var _esconderSenha = true;
  var _tipoLogin = [true, false, false];

  @override
  void initState() {
    _loginController = TextEditingController();
    _senhaController = TextEditingController();
    super.initState();
    _loadUser(); // Carregar usuário se houver um salvo
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

  Future<void> _saveUser(User user) async {
    var box = Hive.box<User>('userBox');
    if (_manterConectado) {
      await box.clear();
      await box.add(user);
      
    } else {
      await box
          .clear(); // Limpa o box se o usuário não quiser se manter conectado
    }
  }

  Future<void> _loadUser() async {
    var box = Hive.box<User>('userBox');
    if (box.isNotEmpty) {
      User user = box.getAt(0)!;
      _loginController.text = user.username;
      _senhaController.text = user.password;
    }
  }

  void _login(BuildContext context) async {
    if (_validateFields()) {
      User user = User(
          username: _loginController.text, password: _senhaController.text);
      await _saveUser(user);

      // ignore: use_build_context_synchronously
      context.go('/welcome/${user.username}');
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
              const SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value: _manterConectado,
                    onChanged: (bool? value) {
                      setState(() {
                        _manterConectado = value ?? false;
                      });
                    },
                  ),
                  const Text('Manter-se conectado'),
                ],
              ),
               const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
