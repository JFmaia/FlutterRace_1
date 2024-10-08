import 'package:flutter/material.dart';
import 'package:tacaro/modules/login/repositories/login_repository.dart';
import 'package:tacaro/shared/models/user_model.dart';
import 'package:tacaro/shared/utils/app_state.dart';

class CreateAccountController extends ChangeNotifier {
  final LoginRepository repository;
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _name = "";
  CreateAccountController({
    required this.repository,
  });

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
        final response = await repository.createAccount(
          email: _email,
          password: _password,
          name: _name,
        );
      
        update(AppState.success<UserModel>(response));
      } catch (e) {
        update(AppState.error(e.toString()));
      }
    }
  }
}
