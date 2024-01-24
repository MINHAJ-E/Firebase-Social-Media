// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebsesample/controller/search_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   // String? username;
//   @override
//   Widget build(BuildContext context) {
//     final searchProviser = Provider.of<SearchProvider>(context);
//     return Scaffold(
//       backgroundColor: Colors.grey[400],
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "SEARCH",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "Enter Your UserName",
//               ),
//               onChanged: (value) {
//                 searchProviser.searchMethod(value);
//               },
//             ),
//           ),
//           if (searchProviser.username != null &&
//               searchProviser.username!.length > 3)
//             FutureBuilder<QuerySnapshot>(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .where('email', isEqualTo: searchProviser.username)
//                   .get(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError) {
//                   return Text("Error: ${snapshot.error}");
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 }

//                 if (snapshot.data?.docs.isEmpty ?? true) {
//                   return const Text("No User found!!");
//                 }

//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: snapshot.data?.docs.length ?? 0,
//                     itemBuilder: (context, index) {
//                       final doc = snapshot.data!.docs[index];
//                       return GestureDetector(
//                         child: ListTile(
//                           title: Text(doc['email']),
//                           trailing: FutureBuilder<DocumentSnapshot>(
//                             future: doc.reference
//                                 .collection('followers')
//                                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                                 .get(),
//                             builder: (context, snapshot) {
//                               if (snapshot.hasData) {
//                                 if (snapshot.data?.exists ?? false) {
//                                   return ElevatedButton(
//                                     onPressed: () async {
//                                       await doc.reference
//                                           .collection('followers')
//                                           .doc(FirebaseAuth
//                                               .instance.currentUser!.uid)
//                                           .delete();
//                                       setState(() {});
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.grey[500],
//                                     ),
//                                     child: const Text("UnFollow"),
//                                   );
//                                 } else {
//                                   return ElevatedButton(
//                                     onPressed: () async {
//                                       await doc.reference
//                                           .collection('followers')
//                                           .doc(FirebaseAuth
//                                               .instance.currentUser!.uid)
//                                           .set({
//                                         'time': DateTime.now(),
//                                       });
//                                       setState(() {});
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.grey[600],
//                                     ),
//                                     child: const Text("Follow"),
//                                   );
//                                 }
//                               } else {
//                                 return const CircularProgressIndicator();
//                               }
//                             },
//                           ),
//                         ),
//                         onTap: () {
//                           // Navigator.of(context).push(MaterialPageRoute(
//                           //     builder: (context) => ProfileScreen(
//                           //           key: null,
//                           //           currentUserId: doc.id,
//                           //           visitedUserId: doc.id,
//                           //         )));
//                         },
//                       );
//                     },
//                   ),
//                 );
//               },
//             )
//           else
//             const Text("Username is null or too short."),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebsesample/constant/constants.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? name;
  // List<Map<String, dynamic>> data = [
  //

  // addData() async {
  //   for (var element in data) {
  //     FirebaseFirestore.instance.collection('users').add(element);
  //   }
  //   print('all data addwd');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: "Search.....!"),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (name!.isEmpty) {
                      return ListTile(
                        title: Text(
                          data['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data['email'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    if (data['name']
                        .toString()
                        .toLowerCase()
                        .startsWith(name!.toLowerCase())) {
                      return ListTile(
                        title: Text(
                          data['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data['email'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return Container();
                  },
                );
        },
      ),
    );
  }
}
