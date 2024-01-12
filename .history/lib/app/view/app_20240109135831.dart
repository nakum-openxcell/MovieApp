import 'package:flutter/material.dart';

import '../../core/constants/app_theme.dart';
import '../../routes/app_routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
