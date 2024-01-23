import 'package:firebsesample/model/chat_model.dart';
import 'package:firebsesample/services/databse_services.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  DataBaseService postsservices = DataBaseService();
  TextEditingController textcontroller = TextEditingController();
  List<Mesaage> posts = [];

  Future<void> addPost(String user, String message) async {
    await postsservices.addPost(user, message, []);
    notifyListeners();
  }

  Future<void> deletePost(String postid) async {
    await postsservices.deletePost(postid);
    notifyListeners();
  }

  Future<void> toggleLike(String postid, bool isLiked) async {
    await postsservices.toggleLike(postid, isLiked);
    notifyListeners();
  }
}
