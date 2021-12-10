import 'package:flutter/material.dart';
import 'package:tacaro/modules/login/login_controller.dart';
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
  final controller = LoginController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller.addListener(
      () {
        controller.state.when(
          success: (value) => Navigator.pushReplacementNamed(context, "/home"),
          error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
            (context) => BottomSheet(
              onClosing: () {},
              builder: (context) => Container(
                decoration: BoxDecoration(color: AppTheme.colors.background),
                height: 40,
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    message,
                  ),
                ),
              ),
            ),
          ),
          orElse: () {},
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
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
              vertical: 30,
              horizontal: 40,
            ),
            child: Form(
              key: controller.formKey,
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
                    height: 15,
                  ),
                  InputText(
                    onChanged: (value) => controller.onChange(email: value),
                    label: "Email",
                    hint: "contato@fluterando.com",
                    validator: (value) =>
                        isEmail(value) ? null : "Digite um e-mail valido!",
                  ),
                  SizedBox(height: 18),
                  InputText(
                    onChanged: (value) => controller.onChange(password: value),
                    label: "Senha",
                    hint: "Digite sua senha",
                    obscure: true,
                    validator: (value) => value.length >= 6
                        ? null
                        : "Digite uma senha mais forte!",
                  ),
                  SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: controller,
                    builder: (_, __) => controller.state.when(
                      loading: () => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: CircularProgressIndicator(
                          color: AppTheme.colors.primary,
                        ),
                      ),
                      orElse: () => Column(
                        children: [
                          Button(
                            size: size,
                            label: "Entrar",
                            type: ButtonType.fill,
                            onPressed: () {
                              controller.login();
                            },
                          ),
                          SizedBox(height: 15),
                          Button(
                            size: size,
                            label: "Criar conta",
                            type: ButtonType.outline,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "/login/create-account");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
