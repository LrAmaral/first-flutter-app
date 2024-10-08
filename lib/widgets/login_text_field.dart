import 'package:flutter/material.dart';
import 'package:atividade/class/login_details.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final TiposLogin tipoLogin;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.tipoLogin,
  });

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
      keyboardType: details.keyboardType,
      maxLength: details.maxLength > 0 ? details.maxLength : null,
      inputFormatters: details.inputFormatters,
    );
  }
}
