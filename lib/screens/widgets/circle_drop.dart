import 'package:countries/theme/color_theme.dart';
import 'package:countries/theme/text_theme.dart';
import 'package:flutter/material.dart';

class CircleDrop extends StatelessWidget {
  const CircleDrop({
    required this.onTap,
    required this.text,
    super.key,
  });

  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColor.slid.light,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.normal18.copyWith(
                color: AppColor.slid.dark,
              ),
        ),
      ),
    );
  }
}
