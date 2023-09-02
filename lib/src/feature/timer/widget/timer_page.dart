import '../utils/file_importer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: CustomTimerView()),
        Expanded(child: SectionMaker()),
      ],
    );
  }
}
