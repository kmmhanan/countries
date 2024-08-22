import 'package:countries/controllers/api/country_controller.dart';
import 'package:countries/controllers/common/route_controller.dart';
import 'package:countries/screens/splash_screen.dart';
import 'package:countries/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  final dio = Dio();
  final apiClient = ApiClient(dio);
  Get.put(TextEditingController());
  Get.put(CountryController(apiClient));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final RouteController main = Get.put(RouteController());
    return GetMaterialApp(
      initialRoute: '/splash',
      getPages: main.routeList,
      title: 'Countries',
      theme: ThemeData(fontFamily: 'Inter'),
      home: const SplashScreen(),
    );
  }
}

class HomeScreen {}
