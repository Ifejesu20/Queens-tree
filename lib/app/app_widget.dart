import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka show builder;

import '../constants.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        backgroundColor: backgroundColor
      ),
      initialRoute: '/login',
      builder: asuka.builder,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}