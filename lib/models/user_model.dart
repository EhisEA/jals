class UserModel {
  UserModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
    this.verified,
    this.avatar,
    this.email,
    this.key,
    this.emailNotificationStatus,
  });

  String id;
  String fullName;
  String phoneNumber;
  DateTime dateOfBirth;
  // String dateOfBirth;
  bool verified;
  bool emailNotificationStatus;
  String key;
  String avatar;
  String email;

  factory UserModel.fromMap(Map<String, dynamic> mapData) {
    return UserModel(
      key: mapData["key"],
      id: mapData["id"],
      fullName: mapData["full_name"],
      phoneNumber: mapData["phone_number"],
      dateOfBirth: mapData["date_of_birth"] == null
          ? null
          : DateTime.parse(mapData["date_of_birth"]),
      verified: mapData["verified"],
      avatar: mapData["avatar"],
      email: mapData["email"],
      emailNotificationStatus: mapData["should_receive_notifications"] ?? false,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    try {
      return UserModel(
        key: json["data"]["key"],
        id: json["data"]["user"]["id"],
        fullName: json["data"]["user"]["full_name"],
        phoneNumber: json["data"]["user"]["phone_number"],
        email: json["data"]["user"]["email"],
        dateOfBirth: json["data"]["user"]["date_of_birth"] == null
            ? null
            : DateTime.parse(json["data"]["user"]["date_of_birth"]),
        verified: json["data"]["user"]["verified"],
        avatar: json["data"]["user"]["avatar"],
        emailNotificationStatus: json["data"]["user"]
            ["should_receive_notifications"],
      );
    } catch (e) {
      print("====error======");
      print(e);
      return null;
    }
  }
  factory UserModel.fromJsonWithToken(token, Map<String, dynamic> json) {
    print(json);
    try {
      return UserModel(
        key: token,
        id: json["id"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        verified: json["verified"],
        avatar: json["avatar"],
        emailNotificationStatus: json["should_receive_notifications"],
      );
    } catch (e) {
      print("====error======");
      print(e);
      return null;
    }
  }
  Map<String, dynamic> toJson() => {
        "key": key,
        "id": id,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "date_of_birth": dateOfBirth == null ? null : dateOfBirth.toString(),
        "verified": verified,
        "avatar": avatar,
        "should_receive_notifications": emailNotificationStatus,
      };

  bool isDetailsComplete() {
    if (fullName == null ||
        phoneNumber == null ||
        dateOfBirth == null ||
        avatar == null) {
      return false;
    }
    return true;
  }
}
