import 'package:flutter/material.dart';
import 'package:tacaro/modules/login/pages/create_account/create_account_controller.dart';
import 'package:tacaro/modules/login/repositories/login_repository_impl.dart';
import 'package:tacaro/shared/services/app_database.dart';
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
  late final CreateAccountController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = CreateAccountController(
      repository: LoginRepositoryImpl(database: AppDataBase.instance),
    );

    controller.addListener(
      () {
        controller.state.when(
          success: (value) => Navigator.pop(context),
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
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        leading: BackButton(
          color: AppTheme.colors.backButton,
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
                    style: AppTheme.textStyles.subtitle,
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
                  SizedBox(height: 50),
                  AnimatedBuilder(
                    animation: controller,
                    builder: (_, __) => controller.state.when(
                      loading: () => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 45),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.colors.primary,
                          ),
                        ),
                      ),
                      orElse: () => Button(
                        size: size,
                        label: "Criar conta",
                        type: ButtonType.fill,
                        onPressed: () {
                          controller.create();
                        },
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
