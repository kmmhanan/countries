import 'package:countries/theme/color_theme.dart';
import 'package:countries/theme/text_theme.dart';
import 'package:flutter/material.dart';

class MainSearchBar extends StatelessWidget {
  const MainSearchBar({
    required this.controller,
    required this.onTap,
    super.key,
  });

  final TextEditingController controller;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.slid.dark50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        style: Theme.of(context).textTheme.bold16,
        decoration: InputDecoration(
          fillColor: AppColor.slid.light,
          hintText: "Search",
          hintStyle: Theme.of(context).textTheme.normal16.copyWith(
                color: AppColor.slid.light50,
              ),
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onTap;
                  },
                )
              : null,
        ),
      ),
    );
  }
}
