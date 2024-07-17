import 'package:flutter/material.dart';
import 'package:atividade/classes/login_details.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final TiposLogin tipoLogin;

  const LoginTextField({
    Key? key,
    required this.controller,
    required this.tipoLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = LoginDetails.loginDetails()[tipoLogin]!;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: details.label,
        hintText: details.hintText,
        prefixIcon: details.prefixIcon,
        border: const OutlineInputBorder(),
      ),
      keyboardType: details.keyboardType,
      maxLength: details.maxLength > 0 ? details.maxLength : null,
      inputFormatters: details.inputFormatters,
    );
  }
}
