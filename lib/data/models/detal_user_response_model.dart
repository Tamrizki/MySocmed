class DetailUserResponseModel {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  String? email;
  String? dateOfBirth;
  String? phone;
  LocationModel? location;
  String? registerDate;
  String? updatedDate;

  DetailUserResponseModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.location,
    this.registerDate,
    this.updatedDate,
  });

  factory DetailUserResponseModel.fromJson(Map<String, dynamic> json) =>
      DetailUserResponseModel(
        id: json['id'],
        title: json['title'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        picture: json['picture'],
        gender: json['gender'],
        email: json['email'],
        dateOfBirth: json['dateOfBirth'],
        phone: json['phone'],
        location: json['location'] != null
            ? LocationModel.fromJson(json['location'])
            : null,
        registerDate: json['registerDate'],
        updatedDate: json['updatedDate'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['picture'] = picture;
    data['gender'] = gender;
    data['email'] = email;
    data['dateOfBirth'] = dateOfBirth;
    data['phone'] = phone;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['registerDate'] = registerDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}

class LocationModel {
  String? street;
  String? city;
  String? state;
  String? country;
  String? timezone;

  LocationModel({
    this.street,
    this.city,
    this.state,
    this.country,
    this.timezone,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        street: json['street'],
        city: json['city'],
        state: json['state'],
        country: json['country'],
        timezone: json['timezone'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['timezone'] = timezone;
    return data;
  }
}
