import 'package:flutter/material.dart';
import 'package:tacaro/shared/theme/app_theme.dart';
import 'package:tacaro/shared/widgets/button/button.dart';
import 'package:tacaro/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: ScrollPhysics(
              parent: NeverScrollableScrollPhysics(),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: size.height * 0.32,
                    width: size.width * 0.60,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InputText(
                  onChanged: print,
                  label: "Email",
                  hint: "contato@fluterando.com",
                  validator: (value) =>
                      isEmail(value) ? null : "Digite um e-mail valido!",
                ),
                SizedBox(height: 18),
                InputText(
                  onChanged: print,
                  label: "Senha",
                  hint: "Digite sua senha",
                  obscure: true,
                  validator: (value) =>
                      value.length >= 6 ? null : "Digite uma senha mais forte!",
                ),
                SizedBox(height: 15),
                Button(
                  size: size,
                  label: "Entrar",
                  type: ButtonType.fill,
                  onPressed: () {},
                ),
                SizedBox(height: 30),
                Button(
                  size: size,
                  label: "Criar conta",
                  type: ButtonType.outline,
                  onPressed: () {
                    Navigator.pushNamed(context, "/login/create-account");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
