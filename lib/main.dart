import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_socmed/data/datasource/sqlite_service.dart';

import 'core/app/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  SqlliteService database = SqlliteService();

  @override
  Widget build(BuildContext context) {
    database.database();
    return GetMaterialApp(
      title: "My Socmed",
      initialRoute: AppPages.initialRouteName,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
