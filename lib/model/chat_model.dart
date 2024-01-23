// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Mesaage {
  String? id;
  String? message;
  String? email;
  List<String>? Likes;
  DateTime? timestamp;

  Mesaage({
    this.id,
    this.message,
    this.email,
    this.Likes,
    this.timestamp,
  });

  factory Mesaage.fromJson(String id, Map<String, dynamic> json) {
    return Mesaage(
      id: id,
      email: json['email'],
      message: json['message'],
      Likes: List<String>.from(json['Likes'] ?? []),
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'email': email,
      'message': message,
      'Likes': Likes,
      'timestamp': timestamp,
    };
  }
}
