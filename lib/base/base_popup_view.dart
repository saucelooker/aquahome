// import 'package:aquahome_app/base/base_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../dependency_initializer.dart';
//
// abstract class BasePopupView<T extends BaseViewModel> extends StatefulWidget {
//   const BasePopupView({
//     Key? key,
//   }) : super(key: key);
//
//   Widget build(BuildContext context, T viewModel, Widget? child);
//
//   @override
//   State<BasePopupView> createState() => BasePopupViewState<T>();
// }
//
// class BasePopupViewState<T extends BaseViewModel>
//     extends State<BasePopupView<T>> {
//   T viewModel = serviceLocator<T>();
//
//   @mustCallSuper
//   @override
//   void dispose() {
//     viewModel.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<T>.value(
//         value: serviceLocator<T>(), child: Consumer<T>(builder: widget.build));
//   }
// }
