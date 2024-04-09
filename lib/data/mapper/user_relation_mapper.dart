import 'package:my_socmed/data/models/user_relation_model.dart';
import 'package:my_socmed/domain/entities/user_relation_state.dart';

class UserRelationMapper {
  static UserRelationState toEntity(UserRealtionModel model) =>
      UserRelationState(
        userId: model.userId ?? '',
        isLike: model.isLike == 1,
        isBeFriend: model.isBeFriend == 1,
      );
}
