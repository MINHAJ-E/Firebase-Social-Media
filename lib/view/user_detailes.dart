// import 'package:firebsesample/constant/constants.dart';
// import 'package:firebsesample/model/model.dart';
// import 'package:firebsesample/model/tweet.dart';
// import 'package:firebsesample/services/tweetdatabase.dart';
// import 'package:firebsesample/widgets/tweet_container.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatefulWidget {
//   final String currentUserId;
//   final String visitedUserId;

//   const ProfileScreen({
//     required Key? key,
//     required this.currentUserId,
//     required this.visitedUserId,
//   }) : super(key: key);

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   int _followersCount = 0;
//   int _followingCount = 0;
//   bool _isFollowing = false;
//   int _profileSegmentedValue = 0;
//   List<Tweet> _allTweets = [];
//   List<Tweet> _mediaTweets = [];

//   Map<int, Widget> _profileTabs = <int, Widget>{
//     0: Padding(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: Text(
//         'Tweets',
//         style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w700,
//           color: Colors.white,
//         ),
//       ),
//     ),
//     1: Padding(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: Text(
//         'Media',
//         style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w700,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   };

//   Widget buildProfileWidgets(UserAuthentication author) {
//     switch (_profileSegmentedValue) {
//       case 0:
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: _allTweets.length,
//           itemBuilder: (context, index) {
//             return TweetContainer(
//               currentUserId: widget.currentUserId,
//               author: author,
//               tweet: _allTweets[index],
//               key: null,
//             );
//           },
//         );
//         break;
//       case 1:
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: _mediaTweets.length,
//           itemBuilder: (context, index) {
//             return TweetContainer(
//               currentUserId: widget.currentUserId,
//               author: author,
//               tweet: _mediaTweets[index],
//               key: null,
//             );
//           },
//         );
//         break;
//       default:
//         return Center(
//             child: Text('Something wrong', style: TextStyle(fontSize: 25)));
//         break;
//     }
//   }

//   getFollowersCount() async {
//     int followersCount =
//         await TweetDataBAseServices.followersNum(widget.visitedUserId);
//     if (mounted) {
//       setState(() {
//         _followersCount = followersCount;
//       });
//     }
//   }

//   getFollowingCount() async {
//     int followingCount =
//         await TweetDataBAseServices.followingNum(widget.visitedUserId);
//     if (mounted) {
//       setState(() {
//         _followingCount = followingCount;
//       });
//     }
//   }

//   followOrUnFollow() {
//     if (_isFollowing) {
//       unFollowUser();
//     } else {
//       followUser();
//     }
//   }

//   unFollowUser() {
//     TweetDataBAseServices.unFollowUser(
//         widget.currentUserId, widget.visitedUserId);
//     setState(() {
//       _isFollowing = false;
//       _followersCount--;
//     });
//   }

//   followUser() {
//     TweetDataBAseServices.followUser(
//         widget.currentUserId, widget.visitedUserId);
//     setState(() {
//       _isFollowing = true;
//       _followersCount++;
//     });
//   }

//   setupIsFollowing() async {
//     bool isFollowingThisUser = await TweetDataBAseServices.isFollowingUser(
//       widget.currentUserId,
//       widget.visitedUserId,
//     );
//     setState(() {
//       _isFollowing = isFollowingThisUser;
//     });
//   }

//   // getAllTweets() async {
//   //   List userTweets = await TweetDataBAseServices.getUserTweets(widget.visitedUserId);
//   //   if (mounted) {
//   //     setState(() {
//   //       _allTweets = userTweets;
//   //       _mediaTweets = _allTweets.where((element) => element.image.isNotEmpty).toList();
//   //     });
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     getFollowersCount();
//     getFollowingCount();
//     setupIsFollowing();
//     // getAllTweets();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: FutureBuilder(
//         future:
//             (widget.visitedUserId != null && widget.visitedUserId.isNotEmpty)
//                 ? usersRef.doc(widget.visitedUserId).get()
//                 : null,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData) {
//             print("No data available");
//             return Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(Colors.green),
//               ),
//             );
//           }
//           print("Data retrieved: ${snapshot.data}");
//           // Continue with your UI building logic

//           UserAuthentication userModel =
//               UserAuthentication.fromJson(snapshot.data);

//           return ListView(
//             physics: const BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics()),
//             children: [
//               Container(
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   // ... your decoration code ...
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox.shrink(),
//                       widget.currentUserId == widget.visitedUserId
//                           ? PopupMenuButton(
//                               icon: Icon(
//                                 Icons.more_horiz,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//                               itemBuilder: (_) {
//                                 return <PopupMenuItem<String>>[
//                                   new PopupMenuItem(
//                                     child: Text('Logout'),
//                                     value: 'logout',
//                                   )
//                                 ];
//                               },
//                               // ... your PopupMenuButton code ...
//                             )
//                           : SizedBox(),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 transform: Matrix4.translationValues(0.0, -40.0, 0.0),
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         CircleAvatar(
//                           radius: 45,
//                           // ... your CircleAvatar code ...
//                         ),
//                         Container(
//                           width: 100,
//                           height: 35,
//                           // ... your Container code ...
//                         ),
//                         GestureDetector(
//                           onTap: followOrUnFollow,
//                           child: Container(
//                             width: 100,
//                             height: 35,
//                             // ... your Container code ...
//                           ),
//                         ),
//                       ],
//                     ),
//                     // ... other code ...
//                     buildProfileWidgets(UserAuthentication(
//                         name: userModel.name,
//                         email: userModel.email,
//                         uid: userModel.uid)),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
