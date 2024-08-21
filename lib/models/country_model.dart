import 'package:countries/models/flag_model.dart';
import 'package:countries/models/language_model.dart';
import 'package:countries/models/name_model.dart';

class Country {
  final Flag flags;
  final Name name;
  final List<String> capital;
  final String region;
  final Languages languages;
  final int population;

  Country({
    required this.flags,
    required this.name,
    required this.capital,
    required this.region,
    required this.languages,
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      flags: Flag.fromJson(json['flags']),
      name: Name.fromJson(json['name']),
      capital: List<String>.from(json['capital']),
      region: json['region'],
      languages: Languages.fromJson(json['languages']),
      population: json['population'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flags': flags.toJson(),
      'name': name.toJson(),
      'capital': capital,
      'region': region,
      'languages': languages.toJson(),
      'population': population,
    };
  }
}
