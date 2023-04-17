// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Сохранить`
  String get save {
    return Intl.message(
      'Сохранить',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel {
    return Intl.message(
      'Отмена',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get delete {
    return Intl.message(
      'Удалить',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Далее`
  String get next {
    return Intl.message(
      'Далее',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Повторить`
  String get repeat {
    return Intl.message(
      'Повторить',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `Пропустить`
  String get skip {
    return Intl.message(
      'Пропустить',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Подключить`
  String get connect {
    return Intl.message(
      'Подключить',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Назад`
  String get back {
    return Intl.message(
      'Назад',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Нет доступных модулей`
  String get mainPageEmpty {
    return Intl.message(
      'Нет доступных модулей',
      name: 'mainPageEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Добавить`
  String get mainPageAdd {
    return Intl.message(
      'Добавить',
      name: 'mainPageAdd',
      desc: '',
      args: [],
    );
  }

  /// `Добавить модуль`
  String get mainPageAddPopup {
    return Intl.message(
      'Добавить модуль',
      name: 'mainPageAddPopup',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get mainPageSettingsPopup {
    return Intl.message(
      'Настройки',
      name: 'mainPageSettingsPopup',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settingsPageTitle {
    return Intl.message(
      'Настройки',
      name: 'settingsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Пароль wi-fi`
  String get settingsPagePasswordTitle {
    return Intl.message(
      'Пароль wi-fi',
      name: 'settingsPagePasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Введите пароль wi-fi`
  String get settingsPagePasswordPlaceholder {
    return Intl.message(
      'Введите пароль wi-fi',
      name: 'settingsPagePasswordPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Тема`
  String get settingsPageThemeTitle {
    return Intl.message(
      'Тема',
      name: 'settingsPageThemeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Светлая`
  String get settingsPageLightTheme {
    return Intl.message(
      'Светлая',
      name: 'settingsPageLightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Темная`
  String get settingsPageDarkTheme {
    return Intl.message(
      'Темная',
      name: 'settingsPageDarkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Системная`
  String get settingsPageSystemTheme {
    return Intl.message(
      'Системная',
      name: 'settingsPageSystemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Язык`
  String get settingsPageLanguageTitle {
    return Intl.message(
      'Язык',
      name: 'settingsPageLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Русский`
  String get settingsPageRussianLanguage {
    return Intl.message(
      'Русский',
      name: 'settingsPageRussianLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get settingsPageEnglishLanguage {
    return Intl.message(
      'English',
      name: 'settingsPageEnglishLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Название`
  String get detailPageModuleTitle {
    return Intl.message(
      'Название',
      name: 'detailPageModuleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Введите название`
  String get detailPageModulePlaceholder {
    return Intl.message(
      'Введите название',
      name: 'detailPageModulePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Краткое описание`
  String get detailPageDescription {
    return Intl.message(
      'Краткое описание',
      name: 'detailPageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Заполните описание`
  String get detailPageDescriptionPlaceholder {
    return Intl.message(
      'Заполните описание',
      name: 'detailPageDescriptionPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Режим`
  String get detailPageMode {
    return Intl.message(
      'Режим',
      name: 'detailPageMode',
      desc: '',
      args: [],
    );
  }

  /// `Градиент`
  String get detailPageGradientMode {
    return Intl.message(
      'Градиент',
      name: 'detailPageGradientMode',
      desc: '',
      args: [],
    );
  }

  /// `Температура`
  String get detailPageTemperatureMode {
    return Intl.message(
      'Температура',
      name: 'detailPageTemperatureMode',
      desc: '',
      args: [],
    );
  }

  /// `Яркость`
  String get detailPageIntensity {
    return Intl.message(
      'Яркость',
      name: 'detailPageIntensity',
      desc: '',
      args: [],
    );
  }

  /// `Расписание`
  String get detailPageSchedule {
    return Intl.message(
      'Расписание',
      name: 'detailPageSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Время\nвключения\n\n`
  String get detailPageTimeOn {
    return Intl.message(
      'Время\nвключения\n\n',
      name: 'detailPageTimeOn',
      desc: '',
      args: [],
    );
  }

  /// `Время\nвыключения\n\n`
  String get detailPageTimeOff {
    return Intl.message(
      'Время\nвыключения\n\n',
      name: 'detailPageTimeOff',
      desc: '',
      args: [],
    );
  }

  /// `Вы уверены, что хотите удалить время из расписания?`
  String get detailPageDeleteScheduleDialog {
    return Intl.message(
      'Вы уверены, что хотите удалить время из расписания?',
      name: 'detailPageDeleteScheduleDialog',
      desc: '',
      args: [],
    );
  }

  /// `Вы уверены, что хотите удалить модуль?`
  String get detailPageDeleteModuleDialog {
    return Intl.message(
      'Вы уверены, что хотите удалить модуль?',
      name: 'detailPageDeleteModuleDialog',
      desc: '',
      args: [],
    );
  }

  /// `Убедитесь, что Ваш телефон подключен в wi-fi сети.`
  String get instructionPageWiFi {
    return Intl.message(
      'Убедитесь, что Ваш телефон подключен в wi-fi сети.',
      name: 'instructionPageWiFi',
      desc: '',
      args: [],
    );
  }

  /// `Подключаемый модуль будет работать в wi-fi сети, к которой Ваш телефон подключен в текущий момент и к которой у Вас есть доступ.`
  String get instructionPageWiFiDesc {
    return Intl.message(
      'Подключаемый модуль будет работать в wi-fi сети, к которой Ваш телефон подключен в текущий момент и к которой у Вас есть доступ.',
      name: 'instructionPageWiFiDesc',
      desc: '',
      args: [],
    );
  }

  /// `Подключите модуль к сети питания.`
  String get instructionPagePower {
    return Intl.message(
      'Подключите модуль к сети питания.',
      name: 'instructionPagePower',
      desc: '',
      args: [],
    );
  }

  /// `Если модулей несколько, то производить подключение необходимо строго по-одному.`
  String get instructionPagePowerDesc {
    return Intl.message(
      'Если модулей несколько, то производить подключение необходимо строго по-одному.',
      name: 'instructionPagePowerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Удерживайте кнопку «Reset» в течение 2 секунд.`
  String get instructionPageReset {
    return Intl.message(
      'Удерживайте кнопку «Reset» в течение 2 секунд.',
      name: 'instructionPageReset',
      desc: '',
      args: [],
    );
  }

  /// `В режиме подключения световой индикатор начнёт мигать жёлтым цветом.`
  String get instructionPageResetDesc {
    return Intl.message(
      'В режиме подключения световой индикатор начнёт мигать жёлтым цветом.',
      name: 'instructionPageResetDesc',
      desc: '',
      args: [],
    );
  }

  /// `Подключение к модулю.`
  String get instructionPageConnection {
    return Intl.message(
      'Подключение к модулю.',
      name: 'instructionPageConnection',
      desc: '',
      args: [],
    );
  }

  /// `Не сворачивайте и не закрывайте приложение, подключение займет не более 30 секунд.`
  String get instructionPageConnectionDesc {
    return Intl.message(
      'Не сворачивайте и не закрывайте приложение, подключение займет не более 30 секунд.',
      name: 'instructionPageConnectionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Для подключения требуется пароль wi-fi сети.`
  String get instructionPageEntry {
    return Intl.message(
      'Для подключения требуется пароль wi-fi сети.',
      name: 'instructionPageEntry',
      desc: '',
      args: [],
    );
  }

  /// `Введите пароль`
  String get instructionPageEntryPlaceholder {
    return Intl.message(
      'Введите пароль',
      name: 'instructionPageEntryPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Подключаемый модуль будет работать в wi-fi сети, к которой Ваш телефон подключен в текущий момент и к которой у Вас есть доступ.`
  String get instructionPageEntryDesc {
    return Intl.message(
      'Подключаемый модуль будет работать в wi-fi сети, к которой Ваш телефон подключен в текущий момент и к которой у Вас есть доступ.',
      name: 'instructionPageEntryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Модуль успешно подключен.`
  String get instructionPageSuccess {
    return Intl.message(
      'Модуль успешно подключен.',
      name: 'instructionPageSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Далее Вы сможете изменить название и добавить описание.`
  String get instructionPageSuccessDesc {
    return Intl.message(
      'Далее Вы сможете изменить название и добавить описание.',
      name: 'instructionPageSuccessDesc',
      desc: '',
      args: [],
    );
  }

  /// `При подключении модуля произошла ошибка.`
  String get instructionPageError {
    return Intl.message(
      'При подключении модуля произошла ошибка.',
      name: 'instructionPageError',
      desc: '',
      args: [],
    );
  }

  /// `Чтобы повторить подключение, удерживайте кнопку «Reset» в течение 2 секунд, пока световой индикатор не начнёт мигать жёлтым цветом. Затем нажмите кнопку "Повторить"`
  String get instructionPageErrorDesc {
    return Intl.message(
      'Чтобы повторить подключение, удерживайте кнопку «Reset» в течение 2 секунд, пока световой индикатор не начнёт мигать жёлтым цветом. Затем нажмите кнопку "Повторить"',
      name: 'instructionPageErrorDesc',
      desc: '',
      args: [],
    );
  }

  /// `Для подключения модуля приложению требуется доступ к местоположению.`
  String get instructionPageErrorLocalPermissions {
    return Intl.message(
      'Для подключения модуля приложению требуется доступ к местоположению.',
      name: 'instructionPageErrorLocalPermissions',
      desc: '',
      args: [],
    );
  }

  /// `Убедитесь, что Ваше устройсво подключено к сети wi-fi.`
  String get instructionPageErrorWiFi {
    return Intl.message(
      'Убедитесь, что Ваше устройсво подключено к сети wi-fi.',
      name: 'instructionPageErrorWiFi',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
