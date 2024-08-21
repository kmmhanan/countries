import 'package:countries/theme/color_theme.dart';
import 'package:flutter/material.dart';

class DetailBar extends StatelessWidget {
  const DetailBar({
    this.textStyle,
    required this.content,
    super.key,
  });

  final String content;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.slid.light50,
      ),
      child: Text(
        content,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
