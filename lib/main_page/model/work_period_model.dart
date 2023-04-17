import 'package:json_annotation/json_annotation.dart';

part 'work_period_model.g.dart';

@JsonSerializable()
class WorkPeriodModel {
  String id;
  bool enable;
  DateTime start;
  DateTime end;

  WorkPeriodModel(this.id, this.enable,this.start, this.end);

  factory WorkPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$WorkPeriodModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkPeriodModelToJson(this);
}
