import 'package:my_socmed/data/models/user_model.dart';
import 'package:my_socmed/domain/entities/user.dart';

class ListUserMapper {
  static List<User> toEntities(List<UserModel>? models) =>
      models != null ? models.map((user) => toEntity(user)).toList() : [];

  static User toEntity(UserModel model) => User(
        id: model.id,
        title: model.title,
        firstName: model.firstName,
        lastName: model.lastName,
        picture: model.picture,
      );
}
