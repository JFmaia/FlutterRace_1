import 'package:flutter/material.dart';
import 'package:tacaro/modules/create/create_bottomsheet.dart';
import 'package:tacaro/shared/models/user_model.dart';
import 'package:tacaro/shared/theme/app_theme.dart';
import 'package:tacaro/shared/widgets/bottom_navigator/app_bottom_navigator.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  final List<Widget> pages;
  const HomePage({
    Key? key,
    required this.user,
    required this.pages,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  late final List<Widget> pages = widget.pages;

  void changeIndex(int index) async {
    if (index == 3) {
      await showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          context: context,
          builder: (context) =>
              SingleChildScrollView(child: CreateBottomsheet()));
    } else {
      currentIndex = index;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              key: UniqueKey(),
              child: List.from(pages)[currentIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigator(
        currentIndex: currentIndex,
        onChanged: changeIndex,
      ),
    );
  }
}
