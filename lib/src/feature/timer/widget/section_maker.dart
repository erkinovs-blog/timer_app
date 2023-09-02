import '../utils/file_importer.dart';

class SectionMaker extends StatelessWidget {
  const SectionMaker({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final DataStorage dataStorage = Provider.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.1),
        ValueListenableBuilder(
            valueListenable: dataStorage.isTimerStarted,
            builder: (context, _, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dataStorage.data
                    .map(
                      (e) => ValueListenableBuilder(
                        valueListenable: dataStorage.pageCount,
                        builder: (context, value, child) => _Buttons(
                          item: e,
                          page: value,
                        ),
                      ),
                    )
                    .toList(),
              );
            }),
        Center(
          child: SizedBox(
            width: size.width > 360 ? 250 : 215,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: SizedBox(
                height: 6,
                width: double.infinity,
                child: ColoredBox(
                  color: AppColor.restartIconBGColor,
                  child: ValueListenableBuilder(
                    valueListenable: dataStorage.pageCount,
                    builder: (context, value, child) {
                      return AnimatedAlign(
                        alignment: switch (value) {
                          1 => Alignment.center,
                          2 => Alignment.centerRight,
                          _ => Alignment.centerLeft,
                        },
                        duration: const Duration(milliseconds: 200),
                        child: child!,
                      );
                    },
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: SizedBox(
                        height: 6,
                        width: 55,
                        child: ColoredBox(
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),
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

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.page,
    required this.item,
  });

  final int page;
  final TimerData item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dataStorage = Provider.of(context);
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          AppColor.transparent,
        ),
      ),
      onPressed: dataStorage.onSectionChanged(page, item.id),
      child: (page == item.id)
          ? Text(
              item.sectionName,
              style: TextStyle(
                color: AppColor.mainColor,
                fontSize: size.width > 360 ? 20 : 14,
              ),
            )
          : Text(
              item.sectionName,
              style: TextStyle(
                fontSize: size.width > 360 ? 14 : 10,
              ),
            ),
    );
  }
}
