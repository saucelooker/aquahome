import 'dart:math';
import 'package:aquahome_app/base/base_bl.dart';
import 'package:aquahome_app/main_page/model/light_control_model.dart';
import 'package:aquahome_app/repositories/lights_repository/storage_lights_repository.dart';
import 'package:aquahome_app/services/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../controls/popup_views/options_dialog.dart';
import '../../dependency_initializer.dart';
import '../../request_helper.dart';
import '../../services/api_service.dart';

class MainPageViewModel extends BaseBl {
  final _navService = serviceLocator<NavigationService>();
  final _storageService = serviceLocator<StorageLightsRepository>();

  MainPageViewModel() {
    synchronizationWithModules();
  }

  synchronizationWithModules() async {
    final entitiesList = await _storageService.getAllLights();
    lightsCollection =
        entitiesList.map((e) => LightControlModel(entity: e)).toList();
    notifyListeners();
  }

  deleteModule(String id) async {
    lightsCollection.removeWhere((element) => element.id == id);
    await _storageService.deleteLight(id);
    notifyListeners();
  }

  sendMessage(LightControlModel light) async {
    light.isOn = !light.isOn;
    var result = await ApiService(Dio(), light.id)
        .turnControl(light.isOn ? '1' : '0')
        .catchError((e) => RestHelper.errorHandler(e));
    if (result.response.statusCode == 200) {
      await _storageService.updateLight(light.modelToEntity());
      notifyListeners();
    } else {
      light.isOn = !light.isOn;
    }
  }

  navigateToDetailPage(LightControlModel item) async {
    final result =
        await _navService.navigationTo('/detail_page', navigationParams: item);
    if (result is String && result == 'delete') {
      deleteModule(item.id);
    } else if (result is LightControlModel) {
      await _storageService.updateLight(item.modelToEntity());
      //TODO: Отправить данные на модуль
      notifyListeners();
    }
  }

  changeColor(LightControlModel light) async {
    final color = HSLColor.fromColor(light.color.color);
    int hue = 0;
    int saturation = 0;
    hue = color.hue ~/ (360 / 255);
    saturation =
        (color.saturation * exp(light.color.value / 300) * 120).toInt();
    var result = await ApiService(Dio(), light.id)
        .colorControl(hue.toString(), saturation.toString())
        .catchError((e) => RestHelper.errorHandler(e));
    if (result.response.statusCode == 200) {
      await _storageService.updateLight(light.modelToEntity());
    } else {}
  }

  changeIntensity(LightControlModel light) async {
    var result = await ApiService(Dio(), light.id)
        .intensityControl(light.intensity.value.toString())
        .catchError((e) => RestHelper.errorHandler(e));
    if (result.response.statusCode == 200) {
      await _storageService.updateLight(light.modelToEntity());
    } else {}
  }

  showOptions() async {
    final result = await navigationService.showDialog(
      const OptionsDialog(options: ['Добавить модуль', 'Настройки']));
    if (result is String) {
      switch (result) {
        case 'Добавить модуль':
          //_navService.navigationTo('/search_page');
        addModule(longPress: true);
          break;

        default:
          _navService.navigationTo("/settings_page");
      }
    }
  }
}
