import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(
        right: 26,
        left: 26,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconBottomNavigator(
              icon: Icons.home,
              onTap: () {
                onChanged(0);
              },
              enabled: currentIndex == 0,
            ),
            IconBottomNavigator(
              icon: Icons.add,
              onTap: () {
                onChanged(3);
              },
              enabled: false,
            ),
            IconBottomNavigator(
              icon: Icons.settings,
              onTap: () {
                onChanged(1);
              },
              enabled: currentIndex == 1,
            ),
          ],
        ),
      ),
    );
  }
}
