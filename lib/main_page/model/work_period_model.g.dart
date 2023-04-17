// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_period_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkPeriodModel _$WorkPeriodModelFromJson(Map<String, dynamic> json) =>
    WorkPeriodModel(
      json['id'] as String,
      json['enable'] as bool,
      DateTime.parse(json['start'] as String),
      DateTime.parse(json['end'] as String),
    );

Map<String, dynamic> _$WorkPeriodModelToJson(WorkPeriodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enable': instance.enable,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };
