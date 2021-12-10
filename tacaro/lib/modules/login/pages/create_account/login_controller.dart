import 'package:flutter/material.dart';

class LoginController {
  String _email = "";
  String _password = "";
  final formKey = GlobalKey<FormState>();

  void onChange({String? email, String? password}) {
    _email = email ?? _email;
    _password = password ?? _password;
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void login() {
    if (validate()) {
      // ignore: avoid_print
      print("Pode chamar o backend");
    }
  }
}
