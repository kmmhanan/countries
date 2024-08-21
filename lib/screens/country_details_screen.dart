import 'package:countries/controllers/common/main_controller.dart';
import 'package:countries/models/country_model.dart';
import 'package:countries/screens/layouts/screen_layout.dart';
import 'package:countries/screens/widgets/common_container.dart';
import 'package:countries/screens/widgets/detail_bar.dart';
import 'package:countries/theme/color_theme.dart';
import 'package:countries/theme/text_theme.dart';
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
                CommonContainer(
                  content: 'The official name of "${country.name.common}" is \n"${country.name.official}"',
                  textStyle: Theme.of(context).textTheme.normal16.copyWith(
                        color: AppColor.slid.dark,
                      ),
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 80,
                        bottom: 24,
                        left: 8,
                        right: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColor.slid.light50,
                      ),
                      child: Column(
                        children: [
                          DetailBar(
                            content: 'Capital: ${country.capital.join(', ')}',
                            textStyle: Theme.of(context).textTheme.bold16.copyWith(
                                  color: AppColor.slid.dark,
                                ),
                          ),
                          const SizedBox(height: 8),
                          DetailBar(
                            content: 'Region: ${country.region}',
                            textStyle: Theme.of(context).textTheme.normal16.copyWith(
                                  color: AppColor.slid.dark,
                                ),
                          ),
                          const SizedBox(height: 8),
                          DetailBar(
                            content: 'Population: ${main.formatNumber(country.population)}',
                            textStyle: Theme.of(context).textTheme.normal16.copyWith(
                                  color: AppColor.slid.dark,
                                ),
                          ),
                          const SizedBox(height: 8),
                          DetailBar(
                            content: 'Languages: ${country.languages.toJson().values.join(', ')}',
                            textStyle: Theme.of(context).textTheme.normal16.copyWith(
                                  color: AppColor.slid.dark,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColor.slid.dark50,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        "More details",
                        style: Theme.of(context).textTheme.bold18,
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
