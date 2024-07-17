import 'package:atividade/classes/login_details.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final TextEditingController _controller;
  final TiposLogin tipoLogin;

  const LoginTextField(
      {super.key, required controller, this.tipoLogin = TiposLogin.email})
      : _controller = controller;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  var mapTiposLogin = LoginDetails.loginDetails();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      decoration: InputDecoration(
        label: Text(mapTiposLogin[widget.tipoLogin]!.label),
        hintText: mapTiposLogin[widget.tipoLogin]!.hintText,
        prefixIcon: mapTiposLogin[widget.tipoLogin]!.prefixIcon,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
