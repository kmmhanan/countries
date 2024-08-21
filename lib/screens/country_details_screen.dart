import 'package:countries/models/country_model.dart';
import 'package:countries/screens/layouts/screen_layout.dart';
import 'package:flutter/material.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({required this.country, super.key});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      appBarTitle: country.name.common,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
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
              ),
              const SizedBox(height: 16),
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
                'Population: ${_formatNumber(country.population)}',
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
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (match) => '${match[1]},',
        );
  }
}
