import '../utils/file_importer.dart';

class IconBuilder extends StatelessWidget {
  const IconBuilder({
    required this.icon,
    required this.opacityValue,
    required this.onPressed,
    super.key,
  });

  final String icon;
  final double opacityValue;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: onPressed,
        icon: Image(
          image: AssetImage(icon),
          height: 30,
          width: 30,
        ),
      ),
      AnimatedOpacity(
        opacity: opacityValue,
        duration: const Duration(
          milliseconds: 400,
        ),
        child: const DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.mainColor,
          ),
          child: SizedBox(height: 10, width: 10),
        ),
      ),
    ],
  );
}
