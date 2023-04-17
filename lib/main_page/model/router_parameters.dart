import 'package:json_annotation/json_annotation.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../dependency_initializer.dart';
import '../../repositories/general_data_repository/storage_general_data_repository.dart';

part 'router_parameters.g.dart';

@JsonSerializable()
class RouterParameters {
  String? name;
  String? password;
  String? bssId;

  RouterParameters([this.name, this.password, this.bssId]);

  factory RouterParameters.fromJson(Map<String, dynamic> json) =>
      _$RouterParametersFromJson(json);

  Map<String, dynamic> toJson() => _$RouterParametersToJson(this);
}
