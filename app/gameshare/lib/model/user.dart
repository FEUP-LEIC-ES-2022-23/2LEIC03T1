import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String _about;
  final String _email;
  final String _name;
  final String _img;
  final Timestamp _timestamp;

  Users(
      this._name,
      this._img,
      this._email,
      this._about,
      this._timestamp
      );

  String get name => _name;
  String get about => _about;
  String get email => _email;
  String get img => _img;
  Timestamp get timestamp=>_timestamp;

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      json['userName'],
      json['image'],
      json['email'],
      json['about'],
      json['creationTimestamp']
    );
  }
}
