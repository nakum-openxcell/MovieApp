import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'app/view/app.dart';

final logger = Logger();
Future<void> main() async {
  runApp(
    const App(),
  );
}
