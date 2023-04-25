class UserModel{
  String? userName;
  //String? registerToken;
  String? email;
  String? uid;

  UserModel({
    this.userName,
    //this.registerToken,
    this.email,
    this.uid
  });

  // factory UserModel.fromMap(json) {
  //   return UserModel(
  //     userName: json['userName'],
  //     email: json['email'],
  //     uid: json['uid'],
  //   );
  // }

  UserModel.fromMap(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap(){
    return{
      'userName': userName,
      'email': email,
      'uid': uid,
    };
  }

}

