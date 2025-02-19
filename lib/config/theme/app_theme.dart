import 'package:flutter/material.dart';
import 'package:pagos_app/global/environment.dart';

class AppTheme {

  ThemeData getTheme(){
    final seedColor = Environment.color;
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      listTileTheme:  ListTileThemeData(
        iconColor: seedColor
      )

    );
  }
}