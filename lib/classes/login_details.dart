import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TiposLogin { email, cpf, telefone }

class LoginDetails {
  late final String label;
  late final String hintText;
  late final Icon prefixIcon;
  late final TextInputType keyboardType;
  late final int maxLength;
  late final List<TextInputFormatter> inputFormatters;

  LoginDetails({
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLength = 0,
    this.inputFormatters = const [],
  });

  static Map<TiposLogin, LoginDetails> loginDetails() {
    return {
      TiposLogin.email: LoginDetails(
        label: "E-mail",
        hintText: "usuario@example.com",
        prefixIcon: const Icon(
          Icons.mail,
          color: Colors.blue,
        ),
      ),
      TiposLogin.cpf: LoginDetails(
        label: "CPF",
        hintText: "111.111.111-11",
        prefixIcon: const Icon(
          Icons.perm_identity,
          color: Colors.blue,
        ),
        keyboardType: TextInputType.number,
        maxLength: 11,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
      ),
      TiposLogin.telefone: LoginDetails(
        label: "Telefone",
        hintText: "(11) 11111-1111",
        prefixIcon: const Icon(
          Icons.phone,
          color: Colors.blue,
        ),
        keyboardType: TextInputType.phone,
        maxLength: 11,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
      ),
    };
  }
}
