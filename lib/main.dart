import 'package:flutter/material.dart';
import 'package:timer_app/src/common/services/local_notice_service.dart';
import 'src/common/widget/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNoticeService.setup();
  runApp(const App());
}
