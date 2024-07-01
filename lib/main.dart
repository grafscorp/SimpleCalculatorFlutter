import 'package:calcul/main_page.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions winop = WindowOptions(
    maximumSize: Size(410, 705),
    minimumSize: Size(410, 705),
    size: Size(410, 705),
    center: true,
  );

  windowManager.waitUntilReadyToShow(winop, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Calc",
      home: main_page(),
      debugShowCheckedModeBanner: false,
    );
  }
}
