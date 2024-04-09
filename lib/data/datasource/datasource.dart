import 'package:my_socmed/data/models/detal_user_response_model.dart';
import 'package:my_socmed/data/models/user_response_model.dart';

abstract class DataSource {
  Future<UserResponseModel> getUsers(int page);
  Future<DetailUserResponseModel> getDetailUsers(String userId);
}
