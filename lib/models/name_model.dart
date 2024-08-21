import 'package:countries/models/native_name_model.dart';

class Name {
  final String common;
  final String official;
  final Map<String, NativeName> nativeName;

  Name({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    var nativeNamesJson = json['nativeName'] as Map<String, dynamic>;
    var nativeNameMap = nativeNamesJson.map((key, value) => MapEntry(key, NativeName.fromJson(value)));

    return Name(
      common: json['common'],
      official: json['official'],
      nativeName: nativeNameMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'common': common,
      'official': official,
      'nativeName': nativeName.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}
