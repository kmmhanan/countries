import 'package:countries/screens/country_details_screen.dart';
import 'package:countries/screens/country_list_screen.dart';
import 'package:countries/screens/splash_screen.dart';
import 'package:get/get.dart';

class RouteController extends GetxController {
  final routeList = [
    GetPage(name: '/splash', page: () => const SplashScreen()),
    GetPage(name: '/country_list', page: () => const CountryListScreen()),
    GetPage(name: '/country_details', page: () => CountryDetailsScreen(country: Get.arguments)),
  ];
}
