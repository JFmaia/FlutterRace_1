import 'package:flutter/material.dart';
import 'package:tacaro/shared/theme/app_theme.dart';

enum ButtonType { fill, outline, none }

class Button extends StatelessWidget {
  final String label;
  final ButtonType type;
  final Size size;
  final Function() onPressed;
  const Button({
    Key? key,
    required this.size,
    required this.label,
    this.type = ButtonType.fill,
    required this.onPressed,
  }) : super(key: key);

  TextStyle get textStyle {
    switch (type) {
      case ButtonType.fill:
        return AppTheme.textStyles.buttonBackgroundColor;
      case ButtonType.outline:
        return AppTheme.textStyles.buttonBoldTextColor;
      case ButtonType.none:
        return AppTheme.textStyles.buttonTextColor;
      default:
        throw "INVALID BUTTON TYPE";
    }
  }

  BoxDecoration get boxDecoration {
    switch (type) {
      case ButtonType.fill:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.colors.primary,
        );
      case ButtonType.outline:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.fromBorderSide(
            BorderSide(color: AppTheme.colors.border),
          ),
          color: AppTheme.colors.background,
        );
      case ButtonType.none:
        return BoxDecoration(
          color: Colors.transparent,
        );
      default:
        throw "INVALID BUTTON TYPE";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: size.height * 0.08,
        width: double.maxFinite,
        child: Center(
          child: Text(
            label,
            style: textStyle,
          ),
        ),
        decoration: boxDecoration,
      ),
    );
  }
}
