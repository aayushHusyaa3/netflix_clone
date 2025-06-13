class ProfileModel {
  bool? status;
  String? message;
  Data? data;
  String? token;

  ProfileModel({this.status, this.message, this.data, this.token});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? name;
  String? email;
  int? age;
  int? isKid;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.age,
    this.isKid,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    age = json['age'];
    isKid = json['is_kid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['age'] = age;
    data['is_kid'] = isKid;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
