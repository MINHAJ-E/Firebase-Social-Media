// import 'package:firebsesample/model/model.dart';
// import 'package:firebsesample/model/tweet.dart';
// import 'package:firebsesample/services/tweetdatabase.dart';
// import 'package:flutter/material.dart';

// class TweetContainer extends StatefulWidget {
//   final Tweet tweet;
//   final UserAuthentication author;
//   final String currentUserId;

//   const TweetContainer(
//       {required Key? key,
//       required this.tweet,
//       required this.author,
//       required this.currentUserId})
//       : super(key: key);
//   @override
//   _TweetContainerState createState() => _TweetContainerState();
// }

// class _TweetContainerState extends State<TweetContainer> {
//   int _likesCount = 0;
//   bool _isLiked = false;

//   initTweetLikes() async {
//     bool isLiked = await TweetDataBAseServices.isLikeTweet(
//         widget.currentUserId, widget.tweet);
//     if (mounted) {
//       setState(() {
//         _isLiked = isLiked;
//       });
//     }
//   }

//   likeTweet() {
//     if (_isLiked) {
//       // TweetDataBAseServices.unlikeTweet(widget.currentUserId, widget.tweet);
//       setState(() {
//         _isLiked = false;
//         _likesCount--;
//       });
//     } else {
//       // TweetDataBAseServices.likeTweet(widget.currentUserId, widget.tweet);
//       setState(() {
//         _isLiked = true;
//         _likesCount++;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _likesCount = widget.tweet.likes;
//     initTweetLikes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 // backgroundImage: widget.author.profilePicture.isEmpty
//                 //     ? AssetImage('assets/placeholder.png')
//                 //     : NetworkImage(widget.author.profilePicture),
//                 backgroundColor: Colors.amber,
//               ),
//               SizedBox(width: 10),
//               Text(
//                 widget.author.name!,
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Text(
//             widget.tweet.text,
//             style: TextStyle(
//               fontSize: 15,
//             ),
//           ),
//           widget.tweet.image.isEmpty
//               ? SizedBox.shrink()
//               : Column(
//                   children: [
//                     SizedBox(height: 15),
//                     Container(
//                       height: 250,
//                       decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(10),
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(widget.tweet.image),
//                           )),
//                     )
//                   ],
//                 ),
//           SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       _isLiked ? Icons.favorite : Icons.favorite_border,
//                       color: _isLiked ? Colors.blue : Colors.black,
//                     ),
//                     onPressed: likeTweet,
//                   ),
//                   Text(
//                     _likesCount.toString() + ' Likes',
//                   ),
//                 ],
//               ),
//               Text(
//                 widget.tweet.timestamp.toDate().toString().substring(0, 19),
//                 style: TextStyle(color: Colors.grey),
//               )
//             ],
//           ),
//           SizedBox(height: 10),
//           Divider()
//         ],
//       ),
//     );
//   }
// }
