

import '../utils/file_importer.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final dataStorage = Provider.of(context);
    final size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "POMODORO",
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColor.mainColor,
          ),
        ),
        SizedBox(
          width: switch (size.width) {
            > 600 => size.width * 0.1,
            < 360 => size.width * 0.1,
            _ => size.width * 0.2,
          },
        ),
        Center(
          child: SizedBox.square(
            dimension: 46,
            child: ValueListenableBuilder(
              valueListenable: dataStorage.isSettings,
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: dataStorage.onRefreshTapped(value),
                  child: child,
                );
              },
              child: const Material(
                color: AppColor.restartIconBGColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Center(
                  child: Image(
                    image: AssetImage(AppIcons.refreshIcon),
                    height: 22,
                    width: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
