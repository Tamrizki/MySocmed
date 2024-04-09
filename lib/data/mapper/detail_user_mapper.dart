import 'package:my_socmed/data/models/detal_user_response_model.dart';
import 'package:my_socmed/domain/entities/detail_user.dart';

class DetailUserMapper {
  static DetailUser toEntity(DetailUserResponseModel model) => DetailUser(
        id: model.id,
        title: model.title,
        firstName: model.firstName,
        lastName: model.lastName,
        picture: model.picture,
        gender: model.gender,
        email: model.email,
        dateOfBirth: model.dateOfBirth,
        phone: model.phone,
        location: model.location?.country,
        registerDate: model.registerDate,
        updatedDate: model.updatedDate,
      );
}
