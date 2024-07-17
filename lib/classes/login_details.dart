// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum TiposLogin { email, cpf, telefone }

class LoginDetails {
  late final String label;
  late final String hintText;
  late final Icon prefixIcon;

  LoginDetails({
    required this.label,
    required this.hintText,
    required this.prefixIcon,
  });

  static Map<TiposLogin, LoginDetails> loginDetails() {
    return {
      TiposLogin.email: LoginDetails(
        label: "E-mail",
        hintText: "usuario@example.com",
        prefixIcon: const Icon(Icons.mail),
      ),
      TiposLogin.cpf: LoginDetails(
        label: "CPF",
        hintText: "111.111.111-11",
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      TiposLogin.telefone: LoginDetails(
        label: "Telefone",
        hintText: "(11) 11111-1111",
        prefixIcon: const Icon(Icons.phone),
      ),
    };
  }
}
