import 'dart:ui';

import 'package:aquahome_app/base/base_bl.dart';
import 'package:aquahome_app/base/ref_type_wrapper.dart';
import 'package:aquahome_app/controls/sliders/gradient_slider.dart';
import 'package:aquahome_app/dependency_initializer.dart';
import 'package:aquahome_app/services/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../controls/popup_views/confirm_dialog.dart';
import '../../controls/popup_views/range_time_dialog.dart';
import '../../main_page/model/light_control_model.dart';
import '../../main_page/model/work_period_model.dart';
import '../../request_helper.dart';
import '../../services/api_service.dart';

class DetailPageViewModel extends BaseBl {
  late LightControlModel model;
  String title = '';
  String description = '';

  ColorMode get colorMode => _colorMode;

  set colorMode(ColorMode val) {
    if (val == ColorMode.gradient) {
      colorValue.value =
          model.mode == val && colorValue.value == model.color.value
              ? model.color.value
              : 0;
    } else {
      colorValue.value =
          model.mode == val && colorValue.value == model.color.value
              ? model.color.value
              : 50;
    }
    _colorMode = val;
  }

  late ColorMode _colorMode = ColorMode.temperature;
  late RefTypeWrapper intensity;
  late ColorPickerElement colorValue;
  late List<WorkPeriodModel> schedule;

  final navigationService = serviceLocator<NavigationService>();

  DetailPageViewModel();

  @override
  init(navigationParams) {
    model = navigationParams as LightControlModel;
    colorValue = ColorPickerElement(model.color.color, model.color.value);
    colorMode = model.mode;
    intensity = RefTypeWrapper(model.intensity.value);
    schedule = model.schedule;
  }

  deleteItem() async {
    final result = await navigationService.showDialog(const ConfirmDialog(
        message: 'Вы уверены, что хотите удалить модуль?',
        okButton: 'Удалить'));
    if (result is bool && result == true) {
      //TODO: Сделать апи для скидывания модуля
      navigationService.goBack('delete');
    }
  }

  Future<bool> addWorkTime() async {
    final result = await navigationService.showDialog(const RangeTimeDialog());
    if (result is List<TimeOfDay> && result.length == 2) {
      schedule.insert(
          0,
          WorkPeriodModel(
              DateTime.now().microsecondsSinceEpoch.toString(),
              false,
              DateTime(0, 0, 0, result[0].hour, result[0].minute),
              DateTime(0, 0, 0, result[1].hour, result[1].minute)));
      return true;
      // notifyListeners();
    }
    return false;
  }

  changeWorkTime(WorkPeriodModel item) async {
    final result = await navigationService.showDialog(RangeTimeDialog(
      startTime: TimeOfDay(hour: item.start.hour, minute: item.start.minute),
      endTime: TimeOfDay(hour: item.end.hour, minute: item.end.minute),
    ));
    if (result is List<TimeOfDay> && result.length == 2) {
      item.start = DateTime(0, 0, 0, result[0].hour, result[0].minute);
      item.end = DateTime(0, 0, 0, result[1].hour, result[1].minute);
      notifyListeners();
    }
  }

  Future<bool> deleteWorkTime(WorkPeriodModel item) async {
    final result = await navigationService.showDialog(const ConfirmDialog(
        message: 'Вы уверены, что хотите удалить время из расписания?',
        okButton: 'Удалить'));
    if (result is bool && result == true) {
      schedule.remove(item);
      return true;
      // notifyListeners();
    }
    return false;
  }

  save() async {
    if (title.isNotEmpty) {
      model.title = title;
    }
    if (description.isNotEmpty) {
      model.subtitle = description;
    }
    model.mode = colorMode;
    model.color = colorValue;
    model.intensity = intensity;

    var result = await ApiService(Dio(), model.id)
        .modeControl(model.mode == ColorMode.gradient ? '0' : '1')
        .catchError((e) => RestHelper.errorHandler(e));
    if (result.response.statusCode == 200) {
      navigationService.goBack(model);
    } else {}
  }
}
