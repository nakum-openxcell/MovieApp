import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'app/view/app.dart';

final logger = Logger();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('es', 'SP')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const App(),
    ),
  );
}
