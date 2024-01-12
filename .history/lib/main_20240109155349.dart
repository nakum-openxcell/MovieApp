import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:moviedb_demo/di/service_locator.dart';

import 'app/view/app.dart';

final logger = Logger();
Future<void> main() async {
  setup();
  runApp(
    const App(),
  );
}
