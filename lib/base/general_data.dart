import 'package:flutter/material.dart';

import '../dependency_initializer.dart';
import '../repositories/general_data_repository/storage_general_data_repository.dart';

class GeneralData extends ChangeNotifier {
  late String password;
  late String language;
  late ThemeMode theme;

  init() async {
    password = await serviceLocator<StorageGeneralDataRepository>().getPassword();
    language = await serviceLocator<StorageGeneralDataRepository>().getLanguage();
    theme = await serviceLocator<StorageGeneralDataRepository>().getTheme();
  }

  changeTheme(ThemeMode newTheme){
    theme = newTheme;
    notifyListeners();
  }
}
