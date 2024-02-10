class UserModel {
  String? id;
  String? username;
  String? email;
  String? displayName;
  String? password;
  bool? emailVerified;
  String? image;
  List<String>? roles;
  String? bio;
  String? signature;
  String? url;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.displayName,
      this.password,
      this.emailVerified,
      this.image,
      this.roles,
      this.bio,
      this.signature,
      this.url});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    displayName = json['displayName'];
    password = json['password'];
    emailVerified = json['emailVerified'];
    image = json['image'];
    roles = json['roles'];
    bio = json['bio'];
    signature = json['signature'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['displayName'] = this.displayName;
    data['password'] = this.password;
    data['emailVerified'] = this.emailVerified;
    data['image'] = this.image;
    data['roles'] = this.roles;
    data['bio'] = this.bio;
    data['signature'] = this.signature;
    data['url'] = this.url;

    return data;
  }
}
