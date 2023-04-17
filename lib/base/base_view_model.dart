import 'package:flutter/cupertino.dart';
import '../dependency_initializer.dart';
import '../entities/light_control_entity.dart';
import '../main_page/model/light_control_model.dart';
import '../services/navigation_service.dart';

abstract class BaseViewModel extends ChangeNotifier {
  List<LightControlModel> lightsCollection = [];
  NavigationService navigationService = serviceLocator<NavigationService>();

  init(dynamic navigationParams) {}

  onBackButton() {
    navigationService.goBack();
  }

  Future<void> addModule({bool longPress = false}) async {
    if (longPress) {
      lightsCollection.insert(0,
          LightControlModel(entity: LightControlEntity(id: '192.168.1.129')));
      notifyListeners();
      return;
    }
    var light = await navigationService.navigationTo('/search_page');

    if (light is LightControlModel) {
      lightsCollection.add(light);
      notifyListeners();
    }
  }

  Future<void> tabBarNavigation(String route) async {
    final currentRoute =
        ModalRoute.of(navigationService.navigatorKey.currentState!.context)
            ?.settings
            .name;
    if (currentRoute != route) {
      await navigationService.navigationTo(route);
    }
  }
}
