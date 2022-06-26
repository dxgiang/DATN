part of 'widgets.dart';

class ItemModal extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onPressed;

  const ItemModal(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(primary: CustomColors.kSecondary1),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(icon, color: Colors.black87),
                SizedBox(width: 10.sp),
                TextCustom(text: text, fontSize: 17.sp)
              ],
            )),
      ),
    );
  }
}
