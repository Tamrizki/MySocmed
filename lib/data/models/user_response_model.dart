import 'package:my_socmed/data/models/user_model.dart';

class UserResponseModel {
  final List<UserModel>? data;
  final int? total;
  final int? page;
  final int? limit;

  UserResponseModel({
    this.data,
    this.total,
    this.page,
    this.limit,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        data: json['data'] != null
            ? List<UserModel>.from(
                json['data'].map(
                  (data) => UserModel.fromJson(data),
                ),
              )
            : [],
        total: json['total'],
        page: json['page'],
        limit: json['limit'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    return data;
  }
}
