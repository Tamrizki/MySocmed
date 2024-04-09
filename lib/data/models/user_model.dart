class UserModel {
  final String? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? picture;

  UserModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        title: json['title'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        picture: json['picture'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['picture'] = picture;
    return data;
  }
}
