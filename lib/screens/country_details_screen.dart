import 'package:countries/screens/layouts/screen_layout.dart';
import 'package:flutter/material.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      appBarTitle: "Home Page",
      child: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
