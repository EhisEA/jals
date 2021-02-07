class UserModel {
  String token;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String fullName;
  UserModel({
    this.dateOfBirth,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.token,
  });
  UserModel.fromJson(Map<String, dynamic> data)
      : dateOfBirth = data["date_of_birth"],
        email = data["email"],
        fullName = data["full_name"],
        phoneNumber = data["phone_number"];
}
