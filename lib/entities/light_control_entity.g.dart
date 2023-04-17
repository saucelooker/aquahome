// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_control_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightControlEntity _$LightControlEntityFromJson(Map<String, dynamic> json) =>
    LightControlEntity(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      intensity: (json['intensity'] as num?)?.toDouble() ?? 50,
      colorValue: (json['colorValue'] as num?)?.toDouble() ?? 50,
      colorCode: json['colorCode'] as String? ?? '#FFFFFF',
      isOn: json['isOn'] as int? ?? 1,
      schedule: (json['schedule'] as List<dynamic>?)
          ?.map((e) => WorkPeriodEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      mode: json['mode'] as int? ?? 1,
    );

Map<String, dynamic> _$LightControlEntityToJson(LightControlEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'intensity': instance.intensity,
      'colorValue': instance.colorValue,
      'colorCode': instance.colorCode,
      'isOn': instance.isOn,
      'schedule': instance.schedule,
      'mode': instance.mode,
    };
