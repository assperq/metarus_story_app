//part 'router.gr.dart';

import 'package:auto_route/auto_route.dart';
import 'package:calculator_app/features/material_page/view/material_screen.dart';
import 'package:calculator_app/features/materials_list/view/material_list_screen.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MaterialListRoute.page, initial: true),
    AutoRoute(page: MaterialRouteRoute.page),
  ];
}
