// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouterParameters _$RouterParametersFromJson(Map<String, dynamic> json) =>
    RouterParameters(
      json['name'] as String?,
      json['password'] as String?,
      json['bssId'] as String?,
    );

Map<String, dynamic> _$RouterParametersToJson(RouterParameters instance) =>
    <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'bssId': instance.bssId,
    };
