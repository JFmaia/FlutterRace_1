import 'package:flutter/material.dart';
import 'package:tacaro/modules/login/pages/create_account/create_account_controller.dart';
import 'package:tacaro/shared/theme/app_theme.dart';
import 'package:tacaro/shared/widgets/button/button.dart';
import 'package:tacaro/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final controller = CreateAccountController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        leading: BackButton(
          color: AppTheme.colors.backButton,
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Criando uma conta",
                    style: AppTheme.textStyles.title,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Mantenha seus gastos em dia",
                    style: AppTheme.textStyles.subTitle,
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  InputText(
                    label: "Nome",
                    hint: "Digite seu nome completo",
                    validator: (value) =>
                        value.isNotEmpty ? null : "Digite seu nome completo!",
                    onChanged: (value) => controller.onChange(name: value),
                  ),
                  SizedBox(height: 18),
                  InputText(
                    label: "Email",
                    hint: "contato@fluterando.com",
                    validator: (value) =>
                        isEmail(value) ? null : "Digite um e-mail valido!",
                    onChanged: (value) => controller.onChange(email: value),
                  ),
                  SizedBox(height: 18),
                  InputText(
                    label: "Senha",
                    hint: "Digite sua senha",
                    obscure: true,
                    validator: (value) => value.length >= 6
                        ? null
                        : "Digite uma senha mais forte!",
                    onChanged: (value) => controller.onChange(password: value),
                  ),
                  SizedBox(height: 15),
                  Button(
                    size: size,
                    label: "Criar conta",
                    type: ButtonType.fill,
                    onPressed: () {
                      controller.create();
                    },
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
