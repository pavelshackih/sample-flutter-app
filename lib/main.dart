import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rocket/screens/main_page.dart';
import 'package:flutter/services.dart';
import 'package:rocket/themes.dart';

Future<void> main() async {
  await initializeDateFormatting("ru_ru");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));

    return MaterialApp(
      title: '',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: AppColors.accentColor,
        canvasColor: Colors.transparent,
      ),
      home: MainPage(),
    );
  }
}
