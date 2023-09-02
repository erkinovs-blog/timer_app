import '../utils/file_importer.dart';

class CustomTimerView extends StatelessWidget {
  const CustomTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dataStorage = Provider.of(context);
    return Center(
      child: PageView(
        restorationId: 'timer_view_restoration_id',
        controller: dataStorage.timerPageController,
        physics: const NeverScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: dataStorage.data
            .map<Widget>(
              (e) => Align(
                alignment: Alignment.center,
                child: SizedBox.square(
                  dimension: size.height * 0.33,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColor.mainColor,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox.square(
                      dimension: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ValueListenableBuilder(
                          valueListenable: dataStorage.indicatorValue,
                          builder: (context, value, child) {
                            return CustomIndicator(
                              value: value,
                              width: 10,
                              child: Center(
                                child: Text(
                                  "${((e.selectedTime.value / 1000).ceil() ~/ 60).toString().padLeft(2, "0")}"
                                      ":"
                                      "${((e.selectedTime.value / 1000).ceil() % 60).toString().padLeft(2, "0")}",
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
