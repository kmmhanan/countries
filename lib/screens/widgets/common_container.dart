import 'package:countries/theme/color_theme.dart';
import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    this.textStyle,
    required this.content,
    super.key,
  });

  final String content;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
