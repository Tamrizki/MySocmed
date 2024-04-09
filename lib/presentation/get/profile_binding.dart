import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_socmed/presentation/get/profile_contoller.dart';

import '../../data/datasource/datasource.dart';
import '../../data/datasource/datasource_impl.dart';
import '../../data/repositories/repositories.dart';
import '../../domain/repositories/repositoies_impl.dart';

class ProfileBinding extends Bindings {
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

    Get.put<ProfileController>(
        ProfileController(repositories: Get.find<Repositories>()));
  }
}
