import 'package:aquahome_app/base/base_bl.dart';
import 'package:flutter/material.dart';

import '../../base/general_data.dart';
import '../../dependency_initializer.dart';
import '../../repositories/general_data_repository/storage_general_data_repository.dart';
import '../../services/navigation_service.dart';

class SettingsPageViewModel extends BaseBl {
  late String password;
  late String language;
  late ThemeMode theme;
  final GeneralData _generalData = serviceLocator<GeneralData>();
  final StorageGeneralDataRepository _generalDataDb =
      serviceLocator<StorageGeneralDataRepository>();

  SettingsPageViewModel() {
    password = _generalData.password;
    language = _generalData.language;
    theme = _generalData.theme;
  }

  saveSetting() async {
    await _generalDataDb.savePassword(password);
    await _generalDataDb.saveLanguage(language);
    await _generalDataDb.saveTheme(theme);
    _generalData.changeTheme(theme);
    onBackButton();
  }

  setLanguage(int tab) {
    language = tab == 0 ? 'RU' : 'EN';
  }

  setTheme(int tab) {
    switch (tab) {
      case 0:
        theme = ThemeMode.light;
        break;
      case 1:
        theme = ThemeMode.dark;
        break;
      default:
        theme = ThemeMode.system;
    }
  }
}
