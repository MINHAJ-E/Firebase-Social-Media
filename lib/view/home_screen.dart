// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/controller/chat_provider.dart';
import 'package:firebsesample/model/chat_model.dart';
import 'package:firebsesample/services/databse_services.dart';
import 'package:firebsesample/view/search_screen.dart';
import 'package:firebsesample/widgets/alert_dialogbox.dart';
import 'package:firebsesample/widgets/chat.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  TextEditingController haicontroller = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "CONNECT HUB",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchScreen()));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => alert(context),
              );
              // },
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentUser != null)
              Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Logged in as: ${currentUser!.email}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Mesaage>>(
                stream: DataBaseService().getDataOrderByTimestamp(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final List<Mesaage> posts = snapshot.data!.docs
                      .map(
                        (doc) => doc.data(),
                      )
                      .toList();

                  final List<Mesaage> validPosts = posts
                      .where((post) =>
                          post.email != null && post.email!.isNotEmpty)
                      .toList();

                  return ListView.builder(
                    itemCount: validPosts.length,
                    itemBuilder: (context, index) {
                      Mesaage post = validPosts[index];

                      return Post(
                        msg: post.message ?? '',
                        email: post.email ?? '',
                        index: index,
                        postid: post.id ?? "",
                        Likes: post.Likes ?? [],
                        Follow: post.Follow ?? [],
                        timestamp: post.timestamp,
                        // Follow:post. [],
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextfield(
                      controller:
                          Provider.of<PostProvider>(context).textcontroller,
                      hintText: "Write",
                      obsecureText: true,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final postsProvider =
                          Provider.of<PostProvider>(context, listen: false);

                      if (postsProvider.textcontroller.text.trim().isNotEmpty) {
                        postsProvider.addPost(
                          FirebaseAuth.instance.currentUser!.email ?? "",
                          postsProvider.textcontroller.text,
                        );
                        postsProvider.textcontroller.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter a message before posting.'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
