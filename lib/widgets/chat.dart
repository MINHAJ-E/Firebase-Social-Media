// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/controller/chat_provider.dart';
import 'package:firebsesample/services/databse_services.dart';
import 'package:firebsesample/widgets/delete.dart';
import 'package:firebsesample/widgets/like.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  final String msg;
  final String email;
  final int index;
  final String postid;
  final List<String> Likes;
  final List<String> Follow;
  final DateTime? timestamp;

  const Post({
    Key? key,
    required this.msg,
    required this.email,
    required this.index,
    required this.postid,
    required this.Likes,
    required this.Follow,
    required this.timestamp,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.Likes.contains(FirebaseAuth.instance.currentUser!.email);
    likeCount = widget.Likes.length;
  }

  final currentUsers = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Text(
                'User Name :',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.email,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 130, 119, 119),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 8),
              Like(
                isliked: isLiked,
                onTap: () {
                  //
                  isLiked = !isLiked;
                  if (isLiked) {
                    widget.Likes.add(FirebaseAuth.instance.currentUser!.email!);
                  } else {
                    widget.Likes.remove(
                        FirebaseAuth.instance.currentUser!.email!);
                  }
                  likeCount = widget.Likes.length;
                  //

                  DocumentReference postref = FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.postid);
                  if (isLiked) {
                    postref.update({
                      'Likes': FieldValue.arrayUnion(
                          [FirebaseAuth.instance.currentUser!.email])
                    });
                  } else {
                    postref.update({
                      'Likes': FieldValue.arrayRemove(
                          [FirebaseAuth.instance.currentUser!.email])
                    });
                  }

                  Provider.of<PostProvider>(context, listen: false)
                      .toggleLike(widget.postid, isLiked);
                },
              ),
              const SizedBox(width: 8),
              Text('$likeCount likes'),
              const SizedBox(width: 8),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            DataBaseService().capitalizeFirstLetter(widget.msg),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          if (currentUsers.email == widget.email)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DeleteButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => deleteAlert(context),
                    );
                  },
                ),
              ],
            ),
        ]));
  }

  AlertDialog deleteAlert(BuildContext context) {
    return AlertDialog(
      title: const Text('are you sure ..!'),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<PostProvider>(context, listen: false)
                .deletePost(widget.postid);
            Navigator.of(context).pop();
          },
          child: const Text('DELETE'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
      ],
      elevation: 24.0,
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
