import 'package:countries/screens/widgets/country_list.dart';
import 'package:countries/screens/widgets/filter_dropdown.dart';
import 'package:countries/screens/widgets/main_search_bar.dart';
import 'package:countries/screens/widgets/paginator.dart';
import 'package:countries/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countries/controllers/api/country_controller.dart';
import 'package:countries/screens/layouts/screen_layout.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final CountryController cntry = Get.find();
  final TextEditingController _searchTermController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cntry.fetchCountries(filter: cntry.selectedFilter.value);
    _searchTermController.addListener(() => cntry.applyFiltersAndSorting(_searchTermController));
  }

  @override
  void dispose() {
    _searchTermController.removeListener(() => cntry.applyFiltersAndSorting(_searchTermController));
    _searchTermController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      backButtonActive: false,
      appBarTitle: "Country List",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            MainSearchBar(
              controller: _searchTermController,
              onTap: () => cntry.applyFiltersAndSorting(_searchTermController),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: () => cntry.onSortChanged('ascending'),
                  child: Container(
                    height: 56,
                    width: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.slid.dark50,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: AppColor.slid.light,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const FilterDropdown(),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => cntry.onSortChanged('descending'),
                  child: Container(
                    height: 56,
                    width: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.slid.dark50,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      color: AppColor.slid.light,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const CountryList(),
            const SizedBox(height: 8),
            const Paginator(),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}
