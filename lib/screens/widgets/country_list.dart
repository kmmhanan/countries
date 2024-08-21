import 'package:countries/controllers/api/country_controller.dart';
import 'package:countries/screens/country_details_screen.dart';
import 'package:countries/theme/color_theme.dart';
import 'package:countries/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late CountryController cntry;

  @override
  void initState() {
    super.initState();
    cntry = Get.find<CountryController>();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final controller = Get.find<CountryController>();

        if (controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading...'),
              ],
            ),
          );
        }

        if (controller.filteredCountries.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await _refreshData();
          },
          child: ListView.builder(
            itemCount: controller.filteredCountries.length,
            itemBuilder: (context, index) {
              final country = controller.filteredCountries[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => CountryDetailsScreen(country: country));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.slid.light50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          country.flags.png,
                          width: 80,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            country.name.common,
                            style: Theme.of(context).textTheme.bold18.copyWith(
                                  color: AppColor.slid.dark,
                                ),
                          ),
                          Text(country.capital.join(', ')),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Future<void> _refreshData() async {
    try {
      await cntry.fetchCountries(filter: cntry.selectedFilter.value);
      // _applyFiltersAndSorting();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to refresh data: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
