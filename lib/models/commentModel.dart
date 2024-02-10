class CommentModel {
  String? id;
  String? body;
  String? userId;
  String? threadId;
  Null? parentId;
  int? depth;
  bool? bestAnswer;
  Null? extendedData;
  String? instanceId;
  String? createdAt;
  String? updatedAt;
  User? user;
  Thread? thread;

  CommentModel(
      {this.id,
      this.body,
      this.userId,
      this.threadId,
      this.parentId,
      this.depth,
      this.bestAnswer,
      this.extendedData,
      this.instanceId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.thread});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    userId = json['userId'];
    threadId = json['threadId'];
    parentId = json['parentId'];
    depth = json['depth'];
    bestAnswer = json['bestAnswer'];
    extendedData = json['extendedData'];
    instanceId = json['instanceId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    thread =
        json['Thread'] != null ? new Thread.fromJson(json['Thread']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['userId'] = this.userId;
    data['threadId'] = this.threadId;
    data['parentId'] = this.parentId;
    data['depth'] = this.depth;
    data['bestAnswer'] = this.bestAnswer;
    data['extendedData'] = this.extendedData;
    data['instanceId'] = this.instanceId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.thread != null) {
      data['Thread'] = this.thread!.toJson();
    }
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
  ExtendedData? extendedData;

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
      this.instanceId,
      this.extendedData});

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
    extendedData = json['extendedData'] != null
        ? new ExtendedData.fromJson(json['extendedData'])
        : null;
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
    if (this.extendedData != null) {
      data['extendedData'] = this.extendedData!.toJson();
    }
    return data;
  }
}

class ExtendedData {
  ExtendedData.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Thread {
  String? userId;
  String? title;

  Thread({this.userId, this.title});

  Thread.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['title'] = this.title;
    return data;
  }
}
