import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/controller/authentication_provider.dart';
import 'package:firebsesample/controller/chat_provider.dart';
import 'package:firebsesample/model/chat_model.dart';
import 'package:firebsesample/services/databse_services.dart';
import 'package:firebsesample/view/search_screen.dart';
import 'package:firebsesample/widgets/alert_dialogbox.dart';
import 'package:firebsesample/widgets/chat.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController haicontroller = TextEditingController();
  List<String> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "TWEEETTER",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Provider.of<AutheticationProvider>(context, listen: false)
              //     .signOut();
              //  onPressed: () {
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
                        timestamp: post.timestamp,
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
