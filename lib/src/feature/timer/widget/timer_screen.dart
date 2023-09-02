import '../utils/file_importer.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  @override
  void dispose() {
    final dataStorage = Provider.of(context);
    dataStorage.timer?.cancel();
    dataStorage.timerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataStorage = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: CustomAppBar(),
            ),
            Expanded(
              flex: 4,
              child: ValueListenableBuilder(
                valueListenable: dataStorage.isSettings,
                builder: (context, value, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: value ? const SettingPage() : const TimerPage(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox.square(
        dimension: 75,
        child: ValueListenableBuilder(
          valueListenable: dataStorage.isTimerStarted,
          builder: (context, _, child) {
            return ValueListenableBuilder(
              valueListenable: dataStorage.isSettings,
              builder: (context, value, child) {
                return FloatingActionButton(
                  onPressed: dataStorage.fABPressed(),
                  backgroundColor: AppColor.mainColor,
                  shape: const CircleBorder(),
                  child: Image(
                    image: AssetImage(
                      value ? AppIcons.tickIcon : AppIcons.playIcon,
                    ),
                    height: 30,
                    width: 30,
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: const CustomFABLocation(),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
