import 'package:countries/controllers/common/main_controller.dart';
import 'package:countries/models/country_model.dart';
import 'package:countries/screens/layouts/screen_layout.dart';
import 'package:countries/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({required this.country, super.key});

  final Country country;

  @override
  Widget build(BuildContext context) {
    MainController main = Get.put(MainController());
    return ScreenLayout(
      appBarTitle: country.name.common,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: country.flags.png.isNotEmpty
                      ? Image.network(
                          country.flags.png,
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/placeholder_flag.png',
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            );
                          },
                        )
                      : Container(
                          padding: const EdgeInsets.all(24),
                          alignment: Alignment.center,
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.slid.light50,
                          ),
                          child: Text(
                            'Unfortunatly ${country.name.common} flag not avilable.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.slid.light50,
                  ),
                  child: Text(
                    'Unfortunatly ${country.name.common} flag not avilable.',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.slid.light50,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Capital: ${country.capital.join(', ')}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Region: ${country.region}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Population: ${main.formatNumber(country.population)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Languages: ${country.languages.toJson().values.join(', ')}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
