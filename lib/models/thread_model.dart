class ThreadModel {
  String? id;
  String? title;
  String? slug;
  String? body;
  int? views;
  String? userId;
  bool? locked;
  bool? pinned;
  Null? bestAnswerId;
  Null? extendedData;
  String? instanceId;
  String? createdAt;
  String? updatedAt;
  User? user;
  List<Null>? likes;
  List<Null>? upvotes;
  List<Null>? tags;
  Null? poll;

  ThreadModel({
    this.id,
    this.title,
    this.slug,
    this.body,
    this.views,
    this.userId,
    this.locked,
    this.pinned,
    this.bestAnswerId,
    this.extendedData,
    this.instanceId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.likes,
    this.upvotes,
    this.tags,
    this.poll,
  });

  ThreadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    body = json['body'];
    views = json['views'];
    userId = json['userId'];
    locked = json['locked'];
    pinned = json['pinned'];
    bestAnswerId = json['bestAnswerId'];
    extendedData = json['extendedData'];
    instanceId = json['instanceId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['body'] = this.body;
    data['views'] = this.views;
    data['userId'] = this.userId;
    data['locked'] = this.locked;
    data['pinned'] = this.pinned;
    data['bestAnswerId'] = this.bestAnswerId;
    data['extendedData'] = this.extendedData;
    data['instanceId'] = this.instanceId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['poll'] = this.poll;
    return data;
  }
}

class User {
  String? id;
  String? displayName;
  String? username;
  String? email;
  String? password;
  bool? emailVerified;
  Null? image;
  bool? isOnline;
  String? registrationIp;
  String? lastIp;
  String? lastSeenAt;
  Null? bio;
  Null? signature;
  Null? url;
  String? createdAt;
  String? updatedAt;
  String? instanceId;

  User(
      {this.id,
      this.displayName,
      this.username,
      this.email,
      this.password,
      this.emailVerified,
      this.image,
      this.isOnline,
      this.registrationIp,
      this.lastIp,
      this.lastSeenAt,
      this.bio,
      this.signature,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.instanceId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    emailVerified = json['emailVerified'];
    image = json['image'];
    isOnline = json['isOnline'];
    registrationIp = json['registrationIp'];
    lastIp = json['lastIp'];
    lastSeenAt = json['lastSeenAt'];
    bio = json['bio'];
    signature = json['signature'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    instanceId = json['instanceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['emailVerified'] = this.emailVerified;
    data['image'] = this.image;
    data['isOnline'] = this.isOnline;
    data['registrationIp'] = this.registrationIp;
    data['lastIp'] = this.lastIp;
    data['lastSeenAt'] = this.lastSeenAt;
    data['bio'] = this.bio;
    data['signature'] = this.signature;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['instanceId'] = this.instanceId;
    return data;
  }
}
