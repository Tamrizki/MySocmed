class UserRealtionModel {
  String? userId;
  int? isLike;
  int? isBeFriend;

  UserRealtionModel({
    this.userId,
    this.isLike,
    this.isBeFriend,
  });

  factory UserRealtionModel.fromJson(Map<String, dynamic> json) =>
      UserRealtionModel(
          isBeFriend: json['friendState'],
          isLike: json['likeState'],
          userId: json['userId']);
}
