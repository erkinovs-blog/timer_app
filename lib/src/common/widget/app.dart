import '../../feature/timer/utils/file_importer.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final DataStorage dataStorage = DataStorage();

  @override
  Widget build(BuildContext context) {
    return Provider(
      dataStorage: dataStorage,
      child: MaterialApp(
        title: "Timer App G7",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Poppins",
        ),
        home: const TimerScreen(),
      ),
    );
  }
}
