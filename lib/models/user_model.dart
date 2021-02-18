class UserModel {
  UserModel({
    this.user,
    this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
    this.verified,
    this.avatar,
    this.key,
  });

  int user;
  String fullName;
  String phoneNumber;
  // DateTime dateOfBirth;
  String dateOfBirth;
  bool verified;
  String key;
  String avatar;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        key: json["data"]["key"],
        user: json["data"]["user"]["user"],
        fullName: json["data"]["user"]["full_name"],
        phoneNumber: json["data"]["user"]["phone_number"],
        dateOfBirth: json["data"]["user"]["date_of_birth"],
        // dateOfBirth: json["data"]["user"]
        //     ["${DateTime.parse(json["date_of_birth"])}"],
        verified: json["data"]["user"]["verified"],
        avatar: json["data"]["user"]["avatar"],
      );

  // Map<String, dynamic> toJson() => {
  //       "user": user,
  //       "full_name": fullName,
  //       "phone_number": phoneNumber,
  //       "date_of_birth":
  //           "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
  //       "verified": verified,
  //       "avatar": avatar,
  //     };
}
