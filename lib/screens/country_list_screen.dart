import 'package:countries/screens/widgets/country_list.dart';
import 'package:countries/screens/widgets/paginator.dart';
import 'package:countries/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countries/controllers/api/country_controller.dart';
import 'package:countries/controllers/common/main_controller.dart';
import 'package:countries/screens/layouts/screen_layout.dart';

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

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final MainController main = Get.put(MainController());
  late CountryController cntry;
  String? _selectedFilter;
  String? _selectedSort;
  String? _itemsPerPage;
  final TextEditingController _searchTermController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cntry = Get.find<CountryController>();
    _selectedFilter = 'name'; // Default filter
    _selectedSort = 'ascending'; // Default sort order
    _itemsPerPage = '10'; // Default items per page

    // Fetch countries with the default filter
    cntry.fetchCountries(filter: _selectedFilter!);

    // Add a listener to the search box to apply filters as the user types
    _searchTermController.addListener(_applyFiltersAndSorting);
  }

  @override
  void dispose() {
    _searchTermController.removeListener(_applyFiltersAndSorting);
    _searchTermController.dispose();
    super.dispose();
  }

  void _applyFiltersAndSorting() {
    if (_selectedFilter != null && _selectedSort != null) {
      cntry.filterAndSort(
        filter: _selectedFilter!,
        sort: _selectedSort!,
        searchTerm: _searchTermController.text,
      );
    }
  }

  void _onFilterChanged(String? newFilter) {
    if (newFilter != null) {
      setState(() {
        _selectedFilter = newFilter;
      });
      cntry.fetchCountries(filter: newFilter); // Fetch data with the selected filter
      _applyFiltersAndSorting(); // Apply sorting and filtering after fetching
    }
  }

  void _onSortChanged(String? newSort) {
    if (newSort != null) {
      setState(() {
        _selectedSort = newSort;
      });
      _applyFiltersAndSorting(); // Apply sorting with the new sort order
    }
  }

  void _onItemsPerPageChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _itemsPerPage = newValue;
      });
      cntry.setItemsPerPage(int.parse(newValue)); // Set items per page
      _applyFiltersAndSorting(); // Apply filters and sorting with new items per page
    }
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedFilter,
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
                          child: Text(value.customCapitalizeFirst),
                        );
                      }).toList(),
                      onChanged: _onFilterChanged,
                      hint: const Text('Select filter'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedSort,
                      items: <String>[
                        'ascending',
                        'descending'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.customCapitalizeFirst),
                        );
                      }).toList(),
                      onChanged: _onSortChanged,
                      hint: const Text('Select sort order'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _itemsPerPage,
                      items: <String>[
                        '10',
                        '15',
                        '20'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('$value items per page'),
                        );
                      }).toList(),
                      onChanged: _onItemsPerPageChanged,
                      hint: const Text('Items per page'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.slid.dark50,
              ),
              // padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchTermController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: const OutlineInputBorder(),
                  suffixIcon: _searchTermController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchTermController.clear();
                            _applyFiltersAndSorting();
                          },
                        )
                      : null,
                ),
              ),
            ),
            const CountryList(),
            if (!cntry.isLoading.value && cntry.countries.isEmpty) ...[
              ElevatedButton(
                onPressed: () {
                  cntry.fetchCountries(); // Retry fetching countries
                },
                child: const Text('Try Again'),
              ),
            ],
            const SizedBox(height: 8),
            const Paginator(),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}
