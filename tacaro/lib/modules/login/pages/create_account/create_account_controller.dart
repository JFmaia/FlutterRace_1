import 'package:flutter/material.dart';

class CreateAccountController {
  String _email = "";
  String _password = "";
  String _name = "";
  final formKey = GlobalKey<FormState>();

  void onChange({String? email, String? password, String? name}) {
    _email = email ?? _email;
    _password = password ?? _password;
    _name = name ?? _name;
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void create() {
    if (validate()) {
      // ignore: avoid_print
      print("Pode chamar o backend");
    }
  }
}
