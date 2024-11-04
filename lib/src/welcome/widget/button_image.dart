import 'package:costus/src/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class ButtonImage extends StatelessWidget {
  const ButtonImage(
      {super.key,
      this.isSelected,
      this.isBig,
      this.color,
      required this.text,
      required this.image,
      required this.onPress});

  final bool? isSelected;
  final bool? isBig;
  final Color? color;
  final String text;
  final String image;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(
              color: isSelected == true ? primary : color ?? white, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: isBig == true ? 60 : 20,
            vertical: isBig == true ? 40 : 10),
        child: Column(
          children: [
            Image.asset(
              'assets/images/$image.png',
              color: isSelected == true ? primary : color ?? white,
              width: isBig == true ? 60 : 40,
              height: isBig == true ? 60 : 40,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
            )
          ],
        ),
      ),
    );
  }
}
