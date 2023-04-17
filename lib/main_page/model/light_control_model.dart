import 'package:aquahome_app/base/ref_type_wrapper.dart';
import 'package:aquahome_app/controls/sliders/gradient_slider.dart';
import 'package:aquahome_app/entities/work_period_entity.dart';
import 'package:aquahome_app/entities/light_control_entity.dart';
import 'package:aquahome_app/extensions.dart';
import 'package:aquahome_app/main_page/model/work_period_model.dart';

class LightControlModel {
  late String id;
  late String title;
  late String subtitle;
  late RefTypeWrapper intensity;
  late ColorPickerElement color;
  late bool isOn;
  late List<WorkPeriodModel> schedule;
  late ColorMode mode;

  LightControlModel({required LightControlEntity entity}) {
    id = entity.id;
    title = entity.title.isNotEmpty ? entity.title : 'Новый модуль';
    subtitle = entity.subtitle;
    intensity = RefTypeWrapper(entity.intensity);
    color = ColorPickerElement(entity.colorCode.toColor(), entity.colorValue);
    mode = entity.mode == 0 ? ColorMode.gradient : ColorMode.temperature;
    isOn = entity.isOn == 1;
    if (entity.schedule != null) {
      schedule = entity.schedule!
          .map((e) => WorkPeriodModel(
              e.id,
              e.enable == 1,
              DateTime.fromMillisecondsSinceEpoch(e.start),
              DateTime.fromMillisecondsSinceEpoch(e.end)))
          .toList();
    } else {
      schedule = [];
    }
  }

  LightControlEntity modelToEntity() {
    return LightControlEntity(
        id: id,
        title: title,
        subtitle: subtitle,
        intensity: intensity.value,
        colorValue: color.value,
        colorCode: color.color.value.toRadixString(16),
        isOn: isOn ? 1 : 0,
        schedule: schedule
            .map((e) => WorkPeriodEntity(
                id: e.id,
                enable: e.enable ? 1 : 0,
                start: e.start.millisecondsSinceEpoch,
                end: e.end.microsecondsSinceEpoch))
            .toList(),
        mode: mode == ColorMode.gradient ? 0 : 1);
  }
}
