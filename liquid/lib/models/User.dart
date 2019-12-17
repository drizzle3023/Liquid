
class User {
  String userId;
  String uid;
  dynamic dateTime;
  String ipAddress;
  String browser;
  String firstName;
  String lastName;
  String gender;
  String birthday;
  String nationality;
  String residenceCity;
  String residenceCountry;
  String phone;
  String email;
  String password;
  String photoAvatarUrl;
  String photoEmploymentUrl;
  dynamic memberSinceDate;
  int paymentPlan;
  bool isActive;
  bool isUploadedPhotos;

  User({
    this.userId,
    this.uid,
    this.dateTime,
    this.ipAddress,
    this.browser,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthday,
    this.nationality,
    this.residenceCity,
    this.residenceCountry,
    this.phone,
    this.email,
    this.password,
    this.photoAvatarUrl,
    this.photoEmploymentUrl,
    this.memberSinceDate,
    this.paymentPlan,
    this.isActive,
    this.isUploadedPhotos
  });

  Map<String, Object> toJson() {
    return {
      'userId': userId == null ? '' : userId,
      'uid': uid == null ? '' : uid,
      'dateTime': dateTime == null ? '' : dateTime,
      'ipAddress': ipAddress == null ? '' : ipAddress,
      'browser': browser == null ? '' : browser,
      'firstName': firstName == null ? '' : firstName,
      'lastName': lastName == null ? '' : lastName,
      'gender': gender == null ? '' : gender,
      'birthday': birthday == null ? '' : birthday,
      'nationality': nationality == null ? '' : nationality,
      'residenceCity': residenceCity == null ? '' : residenceCity,
      'residenceCountry': residenceCountry == null ? '' : residenceCountry,
      'phone': phone == null ? '' : phone,
      'email': email == null ? '' : email,
      'password': password == null ? '' : password,
      'photoAvatarUrl': photoAvatarUrl == null ? '' : photoAvatarUrl,
      'photoEmploymentUrl': photoEmploymentUrl == null ? '' : photoEmploymentUrl,
      'memberSinceDate': memberSinceDate == null ? '' : memberSinceDate,
      'paymentPlan': paymentPlan == null ? '' : paymentPlan,
      'isActive': isActive == null ? false : isActive,
      'isUploadedPhotos': isUploadedPhotos == null ? false : isUploadedPhotos
    };
  }

  factory User.fromJson(Map<dynamic, dynamic> doc) {
    User user = new User(
      userId: doc['userId'],
      uid: doc['uid'],
      dateTime: doc['dateTime'],
      ipAddress: doc['ipAddress'],
      browser: doc['browser'],
      firstName: doc['firstName'],
      lastName: doc['lastName'],
      gender: doc['gender'],
      birthday: doc['birthday'],
      nationality: doc['nationality'],
      residenceCity: doc['residenceCity'],
      residenceCountry: doc['residenceCountry'],
      phone: doc['phone'],
      email: doc['email'],
      password: doc['password'],
      photoAvatarUrl: doc['photoAvatarUrl'],
      photoEmploymentUrl: doc['photoEmploymentUrl'],
      memberSinceDate: doc['memberSinceDate'],
      paymentPlan: doc['paymentPlan'] == "" ? 0 : (int.tryParse(doc['paymentPlan'].toString()) ?? 0),
      isActive: doc['isActive'],
      isUploadedPhotos: doc['isUploadedPhotos'],
    );
    return user;
  }

}