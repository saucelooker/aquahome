import 'package:aquahome_app/base/base_bl.dart';
import 'package:aquahome_app/entities/light_control_entity.dart';
import 'package:esptouch_flutter/esptouch_flutter.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../dependency_initializer.dart';
import '../main_page/model/light_control_model.dart';
import '../main_page/model/router_parameters.dart';
import '../repositories/general_data_repository/storage_general_data_repository.dart';
import '../repositories/lights_repository/storage_lights_repository.dart';
import '../services/navigation_service.dart';

class InstructionPageViewModel extends BaseBl {
  ConnectionStatus connectionState = ConnectionStatus.briefing;
  LightControlModel? light;
  RouterParameters routerParameters = RouterParameters();
  String? error;

  changeConnectionStatus(ConnectionStatus status) {
    connectionState = status;
    if (status == ConnectionStatus.connection) {
      connectToModule();
    } else if (status == ConnectionStatus.success ||
        status == ConnectionStatus.error) {
      HapticFeedback.lightImpact();
    }
    notifyListeners();
  }

  savePassword() async {
    if (routerParameters.password?.isEmpty ?? true) {
      return;
    }
    //89184099989
    await serviceLocator<StorageGeneralDataRepository>()
        .savePassword(routerParameters.password!);
    changeConnectionStatus(ConnectionStatus.connection);
    connectToModule();
  }

  connectToModule() async {
    try {
      PermissionWithService locationPermission = Permission.locationWhenInUse;

      var permissionStatus = await locationPermission.status;
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await locationPermission.request();
      }

      if (permissionStatus == PermissionStatus.granted) {
        bool isLocationServiceOn =
            await locationPermission.serviceStatus.isEnabled;
        if (isLocationServiceOn) {
          error = null;
          final info = NetworkInfo();
          String ssid = await info.getWifiName() as String;
          routerParameters.name = ssid.replaceAll('"', '');
          routerParameters.bssId = await info.getWifiBSSID() as String;
          if (routerParameters.password == null) {
            final password =
                await serviceLocator<StorageGeneralDataRepository>()
                    .getPassword();
            if (password.isEmpty) {
              await Future.delayed(const Duration(milliseconds: 1200));
              changeConnectionStatus(ConnectionStatus.entry);
              return;
            } else {
              routerParameters.password = password;
            }
          }
          final task = ESPTouchTask(
              ssid: routerParameters.name!,
              bssid: routerParameters.bssId!,
              password: routerParameters.password!,
              taskParameter: const ESPTouchTaskParameter());

          final Stream<ESPTouchResult> stream = task.execute();

          final result = await stream
              .firstWhere((element) => element.ip.isNotEmpty)
              .timeout(const Duration(seconds: 30),
                  onTimeout: () => const ESPTouchResult('', ''));
          if (result.ip.isNotEmpty) {
            final lightEntity = LightControlEntity(id: result.ip);
            light = LightControlModel(entity: lightEntity);
            await serviceLocator<StorageLightsRepository>()
                .addNewLight(lightEntity);
            changeConnectionStatus(ConnectionStatus.success);
          } else {
            changeConnectionStatus(ConnectionStatus.error);
          }
        } else {
          error = locale.instructionPageErrorLocalPermissions;
          changeConnectionStatus(ConnectionStatus.error);
        }
      } else {
        error = locale.instructionPageErrorLocalPermissions;
        changeConnectionStatus(ConnectionStatus.error);
      }
    } on TypeError {
      error = locale.instructionPageErrorWiFi;
      changeConnectionStatus(ConnectionStatus.error);
    } catch (e) {
      changeConnectionStatus(ConnectionStatus.error);
    }
  }

  @override
  onBackButton() {
    if (connectionState == ConnectionStatus.briefing ||
        connectionState == ConnectionStatus.error ||
        connectionState == ConnectionStatus.entry) {
      serviceLocator<NavigationService>().goBack();
    } else if (connectionState == ConnectionStatus.success) {
      serviceLocator<NavigationService>().goBack(light);
    } else {
      return;
    }
  }
}

enum ConnectionStatus {
  briefing,
  connection,
  entry,
  success,
  error,
}
