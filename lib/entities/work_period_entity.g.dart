// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_period_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkPeriodEntity _$WorkPeriodEntityFromJson(Map<String, dynamic> json) =>
    WorkPeriodEntity(
      id: json['id'] as String? ?? '',
      enable: json['enable'] as int? ?? 0,
      start: json['start'] as int? ?? 0,
      end: json['end'] as int? ?? 0,
    );

Map<String, dynamic> _$WorkPeriodEntityToJson(WorkPeriodEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enable': instance.enable,
      'start': instance.start,
      'end': instance.end,
    };
