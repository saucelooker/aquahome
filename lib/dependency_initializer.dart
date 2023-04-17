import 'package:aquahome_app/datail_page/view_models/detail_page_view_model.dart';
import 'package:aquahome_app/repositories/general_data_repository/storage_general_data_repository.dart';
import 'package:aquahome_app/services/navigation_service.dart';
import 'package:aquahome_app/settings_page/view_models/settings_page_view_model.dart';
import 'package:aquahome_app/style/theme_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'base/general_data.dart';
import 'generated/l10n.dart';
import 'instruction_page/instruction_page_view_model.dart';
import 'main_page/view_models/main_page_view_model.dart';
import 'repositories/lights_repository/api_lights_repository.dart';
import 'repositories/lights_repository/storage_lights_repository.dart';

final serviceLocator = GetIt.instance;

registerRepositories() {
  serviceLocator.registerFactory(() => ApiLightsRepository(dio: Dio()));
  serviceLocator.registerFactory(() => StorageLightsRepository());
  serviceLocator.registerFactory(() => StorageGeneralDataRepository());
}

registerViewModels() {
  serviceLocator.registerFactory(() => MainPageViewModel());
  serviceLocator.registerFactory(() => DetailPageViewModel());
  serviceLocator.registerFactory(() => InstructionPageViewModel());
  serviceLocator.registerFactory(() => SettingsPageViewModel());
}

registerGeneralData() {
  serviceLocator.registerSingleton<GeneralData>(GeneralData());
  serviceLocator.registerLazySingleton(() => NavigationService());
  serviceLocator.registerSingleton<S>(S());
}
