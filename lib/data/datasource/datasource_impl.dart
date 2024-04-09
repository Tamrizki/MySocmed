import 'package:my_socmed/core/consts.dart';
import 'package:my_socmed/data/datasource/datasource.dart';
import 'package:my_socmed/data/models/detal_user_response_model.dart';
import 'package:my_socmed/data/models/user_response_model.dart';
import 'package:dio/dio.dart';

class DataSourceImpl extends DataSource {
  final Dio _client;

  DataSourceImpl({
    required Dio client,
  }) : _client = client;

  @override
  Future<UserResponseModel> getUsers(int page) async {
    final headers = <String, dynamic>{'app-id': EndPoint.appId};
    final params = <String, dynamic>{'page': page, 'limit': limitDataUser};
    final responseJson = await _client.get(
      EndPoint.baseUrl + EndPoint.getUser,
      options: Options(
        headers: headers,
      ),
      queryParameters: params,
    );
    final model = UserResponseModel.fromJson(responseJson.data);
    return model;
  }

  @override
  Future<DetailUserResponseModel> getDetailUsers(String userId) async {
    final headers = <String, dynamic>{'app-id': EndPoint.appId};
    final responseJson = await _client.get(
      '${EndPoint.baseUrl}${EndPoint.getUser}/$userId',
      options: Options(
        headers: headers,
      ),
    );
    final model = DetailUserResponseModel.fromJson(responseJson.data);
    return model;
  }
}
