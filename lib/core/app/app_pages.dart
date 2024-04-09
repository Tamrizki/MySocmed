import 'package:get/get.dart';
import 'package:my_socmed/presentation/get/home_binding.dart';
import 'package:my_socmed/presentation/get/profile_binding.dart';
import 'package:my_socmed/presentation/pages/profile_page.dart';

import '../../presentation/pages/home_page.dart';

class AppPages {
  static const initialRouteName = HomePage.routeName;
  static final routes = [
    GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: ProfilePage.routeName,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    )
  ];
}
