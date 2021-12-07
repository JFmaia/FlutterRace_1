import 'package:flutter/material.dart';

import 'app_theme.dart';

extension TextExt on Text {
  Text get label => Text(
        // ignore: unnecessary_this
        this.data!,
        style: AppTheme.textStyles.label,
      );
}
