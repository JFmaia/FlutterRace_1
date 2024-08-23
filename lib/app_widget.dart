import 'package:flutter/material.dart';
import 'package:tacaro/modules/feed/feed_page.dart';
import 'package:tacaro/modules/home/home_page.dart';
import 'package:tacaro/modules/login/login_page.dart';
import 'package:tacaro/modules/login/pages/create_account/create_account_page.dart';
import 'package:tacaro/modules/profile/profile_page.dart';
import 'package:tacaro/modules/splash/splash.dart';
import 'package:tacaro/shared/models/user_model.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tacaro",
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/login": (context) => const LoginPage(),
        "/login/create-account": (context) => const CreateAccountPage(),
        "/home": (context) => HomePage(
              pages: const [FeedPage(), ProfilePage()],
              user: ModalRoute.of(context)!.settings.arguments as UserModel,
            )
      },
    );
  }
}
