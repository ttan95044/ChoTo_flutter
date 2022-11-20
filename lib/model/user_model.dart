class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phone;
  UserModel({this.uid,this.email,this.phone,this.firstName,this.secondName});

  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      phone: map['phone'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phone': phone,
    };
  }
}