class UserRelationState {
  final String userId;
  bool isLike;
  bool isBeFriend;

  UserRelationState({
    required this.userId,
    required this.isLike,
    required this.isBeFriend,
  });
}
