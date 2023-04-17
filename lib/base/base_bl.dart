import 'package:flutter/cupertino.dart';
import '../dependency_initializer.dart';
import '../generated/l10n.dart';
import '../services/navigation_service.dart';

abstract class BaseBl extends ChangeNotifier {
  final navigationService = serviceLocator<NavigationService>();
  final S locale = serviceLocator<S>();

  init(dynamic navigationParams) {}

  onBackButton() {
    navigationService.goBack();
  }
}
