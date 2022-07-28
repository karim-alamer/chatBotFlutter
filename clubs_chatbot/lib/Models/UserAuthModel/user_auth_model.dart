class UserAuthModel {
  String name;
  String email;
  String password;
  String uid;
  String phoneNumber;
  String countryName;
  DateTime resetDate;
  String profilePhoto;

  Map<String, dynamic> toAppDatabase() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "password": password,
      "phoneNumber": phoneNumber,
      "countryName": countryName,
      "profilePhoto": profilePhoto,
      "resetDate": resetDate == null ? null : resetDate.toIso8601String(),
    };
  }

  UserAuthModel({
    this.name,
    this.email,
    this.countryName,
    this.password,
    this.phoneNumber,
    this.resetDate,
    this.uid,
    this.profilePhoto,
  });

  factory UserAuthModel.getEmptyUserAuthModel() {
    return UserAuthModel(
      countryName: null,
      name: null,
      profilePhoto: null,
      email: null,
      password: null,
      phoneNumber: null,
      resetDate: null,
      uid: null,
    );
  }
  factory UserAuthModel.fromAppDatabase({Map<String, dynamic> map}) {
    return UserAuthModel(
      name: map["name"],
      email: map["email"],
      uid: map["uid"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      countryName: map["countryName"],
      profilePhoto: map["profilePhoto"],
      resetDate: map["resetDate"] == null
          ? null
          : DateTime.parse(
              map["resetDate"],
            ),
    );
  }
  factory UserAuthModel.fromFirebase({Map<String, dynamic> map}) {
    //Timestamp firebaseDate = map["resetDate"];
    return UserAuthModel(
      name: map["name"],
      email: map["email"],
      uid: map["uid"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      countryName: map["countryName"],
      profilePhoto: map["profilePhoto"],
      //resetDate: firebaseDate.toDate(),
    );
  }
}
