import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_socmed/data/datasource/datasource.dart';
import 'package:my_socmed/data/datasource/datasource_impl.dart';
import 'package:my_socmed/data/repositories/repositories.dart';
import 'package:my_socmed/domain/repositories/repositoies_impl.dart';
import 'package:my_socmed/presentation/get/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Dio());

    Get.put<DataSource>(
      DataSourceImpl(
        client: Get.find<Dio>(),
      ),
    );
    Get.put<Repositories>(
      RepositoriesImpl(
        dataSource: Get.find<DataSource>(),
      ),
    );
    Get.put<HomeController>(HomeController(
      repositories: Get.find<Repositories>(),
    ));
  }
}
