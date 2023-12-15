

import 'package:get/get.dart';
import 'package:news_app/Res/Routes/routes_names.dart';
import 'package:news_app/view/category_view.dart';
import 'package:news_app/view/home.dart';
import 'package:news_app/view/splash_view.dart';

class AppRoutes{

  static appRoutes() => [

    GetPage(
      name: RouteNames.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RouteNames.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RouteNames.categoriesScreen,
      page: () => const CategoriesScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),

  ];

}