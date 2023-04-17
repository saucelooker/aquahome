import 'package:aquahome_app/repositories/general_data_repository/i_general_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:json_store/json_store.dart';

class StorageGeneralDataRepository {
  final String _passwordKey = 'passwordKey';
  final String _languageKey = 'languageKey';
  final String _themeKey = 'themeKey';
  final JsonStore _storage = JsonStore(dbName: 'general_data');

  Future<String> getPassword() async {
    var password = await _storage.getItem(_passwordKey);
    if (password?.containsKey(_passwordKey) ?? false) {
      return password![_passwordKey];
    }
    return '';
  }

  Future<bool> savePassword(String password) async {
    await _storage.setItem(_passwordKey, {_passwordKey: password});
    return true;
  }

  Future<String> getLanguage() async {
    var language = await _storage.getItem(_languageKey);
    if (language?.containsKey(_languageKey) ?? false) {
      return language![_languageKey];
    } else {
      await saveLanguage('ru');
      return 'ru';
    }
  }

  Future<bool> saveLanguage(String language) async {
    await _storage.setItem(_languageKey, {_languageKey: language});
    return true;
  }

  Future<ThemeMode> getTheme() async {
    var theme = await _storage.getItem(_themeKey);
    if (theme?.containsKey(_themeKey) ?? false) {
      switch (theme![_themeKey]) {
        case 'ThemeMode.light':
          return ThemeMode.light;
        case 'ThemeMode.dark':
          return ThemeMode.dark;
        default:
          return ThemeMode.system;
      }
    } else {
      await saveTheme(ThemeMode.system);
      return ThemeMode.system;
    }
  }

  Future<bool> saveTheme(ThemeMode theme) async {
    await _storage.setItem(_themeKey, {_themeKey: theme.toString()});
    return true;
  }
}
