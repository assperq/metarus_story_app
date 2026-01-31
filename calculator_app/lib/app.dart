import 'package:calculator_app/generated/l10n.dart';
import 'package:calculator_app/router/router.dart';
import 'package:calculator_app/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: S.current.calculator_app,
      theme: lightTheme,
      routerConfig: _router.config(),
    );
  }
}
