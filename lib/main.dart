import 'package:atividade/classes/login_details.dart';
import 'package:atividade/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Aula08(title: 'Flutter Demo Home Page'),
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
  late final _loginController;
  late final _senhaCotroller;
  var _tipoCampoLogin = TiposLogin.email;
  var _esconderSenha = true;
  var _tipoLogin = [true, false, false];

  void mudarTipoLogin(int idx) {
    setState(() {
      _loginController.text = '';
      _tipoCampoLogin = TiposLogin.values[idx];
      _tipoLogin =
          _tipoLogin.mapIndexed((index, element) => index == idx).toList();
    });
  }

  @override
  void initState() {
    _loginController = TextEditingController();
    _senhaCotroller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _senhaCotroller.dispose();

    super.dispose();
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
              const SizedBox(
                height: 48,
              ),
              // TipoLogin(tipoLogin: _tipoLogin, onPressed: mudarTipoLogin),
              const SizedBox(height: 48),
              LoginTextField(
                controller: _loginController,
                tipoLogin: _tipoCampoLogin,
              ),
              const SizedBox(
                height: 48,
              ),
              TextField(
                controller: _senhaCotroller,
                obscureText: _esconderSenha,
                decoration: InputDecoration(
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
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
                style: 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
