import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tacaro/shared/theme/app_theme.dart';
import 'package:tacaro/shared/widgets/icon_buttom_navigator/icon_buttom_navigator.dart';

class AppBottomNavigator extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;
  const AppBottomNavigator({
    Key? key,
    required this.currentIndex,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppTheme.colors.textEnabled,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButtomNavigator(
            icon: FontAwesomeIcons.home,
            onTap: () {
              onChanged(0);
            },
            enabled: currentIndex == 0,
          ),
          IconButtomNavigator(
            icon: FontAwesomeIcons.plus,
            onTap: () {
              onChanged(3);
            },
            enabled: false,
          ),
          IconButtomNavigator(
            icon: FontAwesomeIcons.userAlt,
            onTap: () {
              onChanged(2);
            },
            enabled: currentIndex == 2,
          ),
        ],
      ),
    );
  }
}
