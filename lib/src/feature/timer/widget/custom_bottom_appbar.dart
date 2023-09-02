import '../utils/file_importer.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dataStorage = Provider.of(context);
    return BottomAppBar(
      color: AppColor.mainColor,
      height: 90,
      shape: const CustomNotch(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      notchMargin: 20,
      padding: const EdgeInsets.only(top: 1),
      child: BottomAppBar(
        color: Colors.white,
        height: 90,
        shape: const CustomNotch(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 20,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ValueListenableBuilder(
                valueListenable: dataStorage.isTimerStarted,
                builder: (context, notUsedValue, _) {
                  return ValueListenableBuilder(
                    valueListenable: dataStorage.isSettings,
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconBuilder(
                          icon: value
                              ? AppIcons.homeOutlinedIcon
                              : AppIcons.homeFilledIcon,
                          opacityValue: value ? 0.0 : 1.0,
                          onPressed: dataStorage.bottomPressed(false),
                        ),
                        child!,
                        IconBuilder(
                          icon: value
                              ? AppIcons.settingFilledIcon
                              : AppIcons.settingsOutlinedIcon,
                          opacityValue: value ? 1.0 : 0.0,
                          onPressed: dataStorage.bottomPressed(true),
                        ),
                      ],
                    ),
                    child: SizedBox(width: size.width > 360 ? 40 : 20),
                  );
                }
              ),
            ),
            const Expanded(flex: 2, child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}

