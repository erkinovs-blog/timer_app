import 'package:flutter/material.dart';
import 'package:timer_app/src/common/data/data_storage.dart';

class Provider extends InheritedWidget {
  final DataStorage dataStorage;

  const Provider({
    super.key,
    required Widget child,
    required this.dataStorage,
  }) : super(child: child);

  static DataStorage of(BuildContext context, {bool listen = false}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<Provider>()!
          .dataStorage;
    } else {
      return (context
              .getElementForInheritedWidgetOfExactType<Provider>()!
              .widget as Provider)
          .dataStorage;
    }
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return false;
  }
}
