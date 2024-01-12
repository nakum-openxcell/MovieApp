import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:moviedb_demo/di/service_locator.dart';

import 'app/view/app.dart';

final logger = Logger();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    const App(),
  );
}
