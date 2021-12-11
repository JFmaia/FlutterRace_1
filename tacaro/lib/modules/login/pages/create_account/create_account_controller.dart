import 'package:flutter/material.dart';
import 'package:tacaro/shared/services/app_database.dart';
import 'package:tacaro/shared/utils/app_state.dart';

class CreateAccountController extends ChangeNotifier {
  String _email = "";
  String _password = "";
  String _name = "";
  final formKey = GlobalKey<FormState>();
  AppState state = AppState.empty();

  void onChange({String? email, String? password, String? name}) {
    _email = email ?? _email;
    _password = password ?? _password;
    _name = name ?? _name;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> create() async {
    if (validate()) {
      try {
        update(AppState.loading());
        await AppDataBase.instance.createAccount(
          email: _email,
          password: _password,
          name: _name,
        );
        update(AppState.success<String>("Deu Certo"));
      } catch (e) {
        update(
          AppState.error("Não foi possivel criar conta."),
        );
      }
    }
  }
}
