part of 'widgets.dart';

class BtnCustom extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double border;
  final Color colorText;
  final Color backgroundColor;
  final double fontSize;
  final VoidCallback? onPressed;

  const BtnCustom(
      {Key? key,
      required this.text,
      required this.width,
      this.onPressed,
      this.height = 50,
      this.border = 8.0,
      this.colorText = Colors.white,
      this.fontSize = 21,
      this.backgroundColor = CustomColors.secundary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border))),
        child: TextCustom(text: text, color: colorText, fontSize: fontSize),
        onPressed: onPressed,
      ),
    );
  }
}