import 'package:my_socmed/domain/entities/data_user.dart';
import 'package:my_socmed/domain/entities/detail_user.dart';

abstract class Repositories {
  Future<DataUser> getUser(int page);
  Future<DetailUser> getDetailUser(String userId);
}
