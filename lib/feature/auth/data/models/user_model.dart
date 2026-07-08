

import '../../domain/entites/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.image,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '' ,
      email: json['email'] ?? '' ,
      firstName: json['firstName'] ?? '' ,
      lastName: json['lastName']?? '' ,
      gender: json['gender'] ?? '' ,
      image: json['image'] ?? '' ,
      accessToken: json['accessToken'] ?? '' ,
      refreshToken: json['refreshToken'] ?? '' ,
    );
  }
}