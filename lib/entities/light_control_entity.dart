import 'package:json_annotation/json_annotation.dart';

import 'work_period_entity.dart';

part 'light_control_entity.g.dart';

@JsonSerializable()
class LightControlEntity {
  String id;
  String title;
  String subtitle;
  double intensity;
  double colorValue;
  String colorCode;
  int isOn;
  List<WorkPeriodEntity>? schedule;
  int mode;

  LightControlEntity(
      {required this.id,
      this.title = '',
      this.subtitle = '',
      this.intensity = 50,
      this.colorValue = 50,
      this.colorCode = '#FFFFFF',
      this.isOn = 1,
      this.schedule,
      this.mode = 1});

  factory LightControlEntity.fromJson(Map<String, dynamic> json) =>
      _$LightControlEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LightControlEntityToJson(this);
}
