import 'dart:async';

import 'package:calculator_app/app.dart';
import 'package:calculator_app/features/materials_list/bloc/material_list_bloc.dart';
import 'package:calculator_app/generated/l10n.dart';
import 'package:calculator_app/repositories/materials/abstract_materials_repository.dart';
import 'package:calculator_app/repositories/materials/materials_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  S.load(const Locale('en', 'US'));
  GetIt.I.registerSingleton<Dio>(Dio());
  GetIt.I.registerSingleton<Talker>(TalkerFlutter.init());
  GetIt.I.registerSingleton<AbstractMaterialsRepository>(
    MaterialsRepositoryImpl(),
  );
  GetIt.I.registerSingleton(MaterialListBloc());

  FlutterError.onError = (details) {
    GetIt.I<Talker>().handle(details.exception, details.stack);
  };

  runZonedGuarded(() => runApp(const MyApp()), (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
