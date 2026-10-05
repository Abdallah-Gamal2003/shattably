class ServiceUserModel {
  late String name;
  late String email;
  late String phone;
  late String image;
  late String uId;
  late String address;
  late bool isEmailVerified;
  late String job;
  late String city;
  late List<String>? fcmToken;
  late String whatsapp;
  // late String locationlink;

  ServiceUserModel({
    required this.uId,
    required this.email,
    required this.name,
    required this.image,
    required this.phone,
    required this.isEmailVerified,
    required this.address,
    required this.job,
    required this.city,
    this.fcmToken,
    required this.whatsapp,
   // required String locationlink,
    // String? locationlink,
  });

  ServiceUserModel.fromJson(Map<String, dynamic>json){
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    address=json['address'];
    isEmailVerified=json['isEmailVerified'];
    job=json['job'];
    city=json['city'];
    whatsapp=json['whatsapp'];
    // locationlink=json['locationlink'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'address':address,
      'job':job,
      'uId':uId,
      'image':image,
      'isEmailVerified':isEmailVerified,
      'city':city,
      'whatsapp':whatsapp,
      // 'locationlink':locationlink,
      'fcm':fcmToken,
    };
  }
}