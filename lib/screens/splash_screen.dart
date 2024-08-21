import 'package:countries/controllers/common/main_controller.dart';
import 'package:countries/screens/country_list_screen.dart';
import 'package:countries/screens/layouts/screen_layout.dart';
import 'package:countries/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MainController main = Get.put(MainController());

  @override
  void initState() {
    _navigatetohome();
    super.initState();
  }

  void _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    main.nameNavTo('/country_list');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      backButtonActive: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: kToolbarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Home Screen ",
              style: TextStyle(color: Colors.transparent),
            ),
            const Spacer(),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(18),
            //   child: Image.network(
            //     "https://flagcdn.com/w320/no.png",
            //     height: 100,
            //     width: 100,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Image.asset(
              "assets/images/app-icon.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const Spacer(),
            Text("Developed By", style: Theme.of(context).textTheme.normal13),
            Text("Kmm Hanan", style: Theme.of(context).textTheme.bold16),
          ],
        ),
      ),
    );
  }
}
