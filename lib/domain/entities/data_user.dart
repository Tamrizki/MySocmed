import 'package:my_socmed/domain/entities/user.dart';

class DataUser {
  final List<User> users;
  final int? total;
  final int? page;

  DataUser({
    required this.users,
    required this.total,
    required this.page,
  });
}
