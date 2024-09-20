import 'package:db_miner_quotesapp/view/home_page.dart';
import 'package:db_miner_quotesapp/view/home_screen.dart';
import 'package:db_miner_quotesapp/view/login_page.dart';
import 'package:db_miner_quotesapp/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen(),),
        GetPage(name: '/login', page: () => const LoginPage(),),
        GetPage(name: '/home', page: () =>  const HomePage(),),
        GetPage(name: '/ho', page: () =>  const HomeScreen(),),
      ],
    );
  }
}