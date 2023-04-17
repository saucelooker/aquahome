import 'package:json_annotation/json_annotation.dart';

part 'work_period_entity.g.dart';

@JsonSerializable()
class WorkPeriodEntity {
  String id;
  int enable;
  int start;
  int end;

  WorkPeriodEntity({
    this.id = '',
    this.enable = 0,
    this.start = 0,
    this.end = 0,
  });

  factory WorkPeriodEntity.fromJson(Map<String, dynamic> json) =>
      _$WorkPeriodEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WorkPeriodEntityToJson(this);
}
