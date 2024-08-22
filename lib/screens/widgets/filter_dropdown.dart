import 'package:countries/controllers/api/country_controller.dart';
import 'package:countries/theme/color_theme.dart';
import 'package:countries/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Extension to capitalize the first letter of a string
extension StringCapitalization on String {
  String get capitalizeFirst {
    return isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension CustomCapitalization on String {
  String get customCapitalizeFirst {
    return isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  }
}

class FilterDropdown extends StatefulWidget {
  const FilterDropdown({super.key});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  final CountryController cntry = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.slid.dark50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Obx(() => DropdownButton<String>(
              iconEnabledColor: AppColor.slid.light,
              alignment: AlignmentDirectional.centerStart,
              borderRadius: BorderRadius.circular(16),
              dropdownColor: AppColor.slid.dark,
              underline: const SizedBox.shrink(),
              value: cntry.selectedFilter.value,
              items: <String>[
                'name',
                'capital',
                'flags',
                'region',
                'languages',
                'population'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value.customCapitalizeFirst,
                    style: Theme.of(context).textTheme.bold16,
                  ),
                );
              }).toList(),
              onChanged: (value) => cntry.onFilterChanged(value),
              hint: const Text('Select filter'),
            )),
      ),
    );
  }
}
