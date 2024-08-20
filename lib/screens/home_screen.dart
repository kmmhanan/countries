import 'package:countries/controllers/common/main_controller.dart';
import 'package:countries/screens/country_details_screen.dart';
import 'package:countries/screens/layouts/screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainController main = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      backButtonActive: false,
      appBarTitle: "Country List",
      child: Column(
        children: [
          Center(
            child: Text("Home Screen"),
          ),
          ElevatedButton(
            onPressed: () => main.navTo(const CountryDetailsScreen()),
            child: Text("Details"),
          ),
          GestureDetector(
            onTap: () => main.navTo(const CountryDetailsScreen()),
            child: Container(
              color: Colors.white,
              width: 200,
              height: 40,
            ),
          )
        ],
      ),
    );
  }
}
