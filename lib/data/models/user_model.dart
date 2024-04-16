class UserModel {
  String? uid;
  String? name;
  String? profile;
  String? createdOn;
  String? email;

  UserModel({
    this.uid,
    this.name,
    this.profile,
    this.createdOn,
    this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'] == "null" ? null : map['name'],
      profile: map['profile'],
      createdOn: map['created_on'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": "$uid",
      "name": "$name",
      "profile": "$profile",
      "created_on": "$createdOn",
      "email": "$email"
    };
  }

  @override
  String toString() {
    return ''' 
    {
    uid: $uid,
    name: $name,
    profile: $profile,
    createdOn: $createdOn,
    email: $email
    }
    ''';
  }
}
