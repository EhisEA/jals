class UserModel {
  UserModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
    this.verified,
    this.avatar,
    this.key,
  });

  String id;
  String fullName;
  String phoneNumber;
  DateTime dateOfBirth;
  // String dateOfBirth;
  bool verified;
  String key;
  String avatar;

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
        dateOfBirth: json["data"]["user"]["date_of_birth"] == null
            ? null
            : DateTime.parse(json["data"]["user"]["date_of_birth"]),
        verified: json["data"]["user"]["verified"],
        avatar: json["data"]["user"]["avatar"],
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
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        verified: json["verified"],
        avatar: json["avatar"],
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
        "date_of_birth": dateOfBirth == null ? null : dateOfBirth.toString(),
        // "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "verified": verified,
        "avatar": avatar,
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
