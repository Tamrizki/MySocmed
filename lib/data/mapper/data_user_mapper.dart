import 'package:my_socmed/data/mapper/user_mapper.dart';
import 'package:my_socmed/data/models/user_response_model.dart';
import 'package:my_socmed/domain/entities/data_user.dart';

class DataUserMapper {
  static DataUser toEntity(UserResponseModel model) => DataUser(
        users: ListUserMapper.toEntities(model.data),
        total: model.total,
        page: model.page,
      );
}
