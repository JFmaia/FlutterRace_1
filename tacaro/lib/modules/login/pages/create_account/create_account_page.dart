import 'package:flutter/material.dart';
import 'package:tacaro/shared/theme/app_theme.dart';
import 'package:tacaro/shared/widgets/button/button.dart';
import 'package:tacaro/shared/widgets/input_text/input_text.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

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
              vertical: 50,
              horizontal: 40,
            ),
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
                ),
                SizedBox(height: 18),
                InputText(
                  label: "Email",
                  hint: "contato@fluterando.com",
                ),
                SizedBox(height: 18),
                InputText(
                  label: "Senha",
                  hint: "Digite sua senha",
                  obscure: true,
                ),
                SizedBox(height: 15),
                Button(
                  size: size,
                  label: "Criar conta",
                  type: ButtonType.fill,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
