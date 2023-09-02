import '../../feature/timer/utils/file_importer.dart';

class DataStorage {
  DataStorage() : timerPageController = PageController();
  final indicatorValue = ValueNotifier<double>(1.0);
  final pageCount = ValueNotifier<int>(0);
  final isSettings = ValueNotifier<bool>(false);
  final isTimerStarted = ValueNotifier<bool>(false);
  final PageController timerPageController;

  Timer? timer;

  List<TimerData> data = [
    TimerData(
      id: 0,
      constTime: 60000,
      sectionName: "short break",
    ),
    TimerData(
      id: 1,
      constTime: 1500000,
      sectionName: "pomodoro",
    ),
    TimerData(
      id: 2,
      constTime: 2400000,
      sectionName: "long break",
    ),
  ];

  void Function()? fABPressed() {
    if (isTimerStarted.value) return null;

    if (isSettings.value) {
      return () async {
        for (int i = 0; i < data.length; i++) {
          data[i].constTime = data[i].selectedTime.value;
        }

        isSettings.value = false;

        await Future.delayed(const Duration(milliseconds: 50), () {
          timerPageController.jumpToPage(
            pageCount.value,
          );
        });
      };
    } else {
      for (int i = 0; i < data.length; i++) {
        data[i].selectedTime.value = data[i].constTime;
      }

      return () {
        isTimerStarted.value = true;

        timer =
            Timer.periodic(const Duration(milliseconds: 20), (timer) async {
          if (indicatorValue.value == 0.0) {
            onRefreshTapped(false)?.call();
            await LocalNoticeService.addNotification(
              title: "Time is up!",
              body: "Click on the notification to restart the session",
              endTime: DateTime.now().millisecondsSinceEpoch + 1000,
              channel: "testing2",
            );
            return;
          }

          data[pageCount.value].selectedTime.value -= 20;
          int timerTime = data[pageCount.value].selectedTime.value;
          indicatorValue.value = timerTime / data[pageCount.value].constTime;
        });
      };
    }
  }

  void Function()? bottomPressed(bool isSettingsTapped) {
    if (isTimerStarted.value) return null;
    if (isSettings.value == isSettingsTapped) return null;

    return () async {
      isSettings.value = isSettingsTapped;

      if (!isSettings.value) {
        await Future.delayed(const Duration(milliseconds: 50), () {
          timerPageController.jumpToPage(
            pageCount.value,
          );
        });
      }
    };
  }

  void Function()? onRefreshTapped(bool isSettingsValue) {
    if (isSettingsValue) return null;

    return () {
      timer?.cancel();

      data[pageCount.value].selectedTime.value =
          data[pageCount.value].constTime;
      indicatorValue.value = 1.0;
      isTimerStarted.value = false;
    };
  }

  void onSettingsClosed() async {
    isSettings.value = false;
    await Future.delayed(const Duration(milliseconds: 50), () {
      timerPageController.jumpToPage(
        pageCount.value,
      );
    });
  }

  void Function()? onSectionChanged(int value, int itemLocation) {
    if (isTimerStarted.value) return null;

    if (value == itemLocation) {
      return () {};
    } else {
      return () {
        pageCount.value = itemLocation;
        timerPageController.animateToPage(
          itemLocation,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      };
    }
  }
}
