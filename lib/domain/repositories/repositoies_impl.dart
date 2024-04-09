import 'package:my_socmed/data/datasource/datasource.dart';
import 'package:my_socmed/data/mapper/data_user_mapper.dart';
import 'package:my_socmed/data/mapper/detail_user_mapper.dart';
import 'package:my_socmed/data/repositories/repositories.dart';
import 'package:my_socmed/domain/entities/data_user.dart';
import 'package:my_socmed/domain/entities/detail_user.dart';

class RepositoriesImpl extends Repositories {
  final DataSource _dataSource;

  RepositoriesImpl({required DataSource dataSource}) : _dataSource = dataSource;
  @override
  Future<DataUser> getUser(int page) async {
    final model = await _dataSource.getUsers(page);
    return DataUserMapper.toEntity(model);
  }

  @override
  Future<DetailUser> getDetailUser(String userId) async {
    final model = await _dataSource.getDetailUsers(userId);
    return DetailUserMapper.toEntity(model);
  }
}
