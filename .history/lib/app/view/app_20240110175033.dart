import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_theme.dart';
import '../../routes/app_routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('You are offline')));
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        initialRoute: '/',
        routes: AppRoutes.routes,
      ),
    );
  }
}
