import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Res/GetX%20Localization/app_localization.dart';
import 'package:news_app/Res/Routes/app_routes.dart';


void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      translations: Languages(),
      locale: const Locale('en', 'Us'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
