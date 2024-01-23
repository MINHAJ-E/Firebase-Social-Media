// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebsesample/constant/constants.dart';
// import 'package:firebsesample/model/Activity.dart';
// import 'package:firebsesample/model/model.dart';
// import 'package:firebsesample/model/tweet.dart';

// class TweetDataBAseServices {
//   static Future<int> followersNum(String userId) async {
//     if (userId == null || userId.isEmpty) {
//       // Handle the case where userId is null or empty
//       return 0; // You may want to return a default value or throw an exception
//     }

//     QuerySnapshot followersSnapshot =
//         await followersRef.doc(userId).collection('Followers').get();
//     return followersSnapshot.docs.length;
//   }

//   static Future<int> followingNum(String userId) async {
//     if (userId == null || userId.isEmpty) {
//       // Handle the case where userId is null or empty
//       return 0; // You may want to return a default value or throw an exception
//     }

//     QuerySnapshot followingSnapshot =
//         await followingRef.doc(userId).collection('Following').get();
//     return followingSnapshot.docs.length;
//   }

//   static void updateUserData(UserAuthentication user) {
//     usersRef.doc(user.name).update({
//       'name': user.name,
//       // 'bio': user.bio,
//       "email": user.email,
//       // 'profilePicture': user.profilePicture,
//       // 'coverImage': user.coverImage,
//     });
//   }

//   static Future<QuerySnapshot> searchUsers(String name) async {
//     Future<QuerySnapshot> users = usersRef
//         .where('name', isGreaterThanOrEqualTo: name)
//         .where('name', isLessThan: name + 'z')
//         .get();

//     return users;
//   }

//   static void followUser(String currentUserId, String visitedUserId) {
//     followingRef
//         .doc(currentUserId)
//         .collection('Following')
//         .doc(visitedUserId)
//         .set({});
//     followersRef
//         .doc(visitedUserId)
//         .collection('Followers')
//         .doc(currentUserId)
//         .set({});

//     // addActivity(currentUserId,, true, visitedUserId);
//   }

//   static void unFollowUser(String currentUserId, String visitedUserId) {
//     followingRef
//         .doc(currentUserId)
//         .collection('Following')
//         .doc(visitedUserId)
//         .get()
//         .then((doc) {
//       if (doc.exists) {
//         doc.reference.delete();
//       }
//     });

//     followersRef
//         .doc(visitedUserId)
//         .collection('Followers')
//         .doc(currentUserId)
//         .get()
//         .then((doc) {
//       if (doc.exists) {
//         doc.reference.delete();
//       }
//     });
//   }

//   static Future<bool> isFollowingUser(
//       String currentUserId, String visitedUserId) async {
//     if (currentUserId == null ||
//         currentUserId.isEmpty ||
//         visitedUserId == null ||
//         visitedUserId.isEmpty) {
//       // Handle the case where either currentUserId or visitedUserId is null or empty
//       return false; // You may want to return a default value or throw an exception
//     }

//     DocumentSnapshot followingDoc = await followersRef
//         .doc(visitedUserId)
//         .collection('Followers')
//         .doc(currentUserId)
//         .get();

//     return followingDoc.exists;
//   }

//   static void createTweet(Tweet tweet) {
//     tweetsRef.doc(tweet.authorId).set({'tweetTime': tweet.timestamp});
//     tweetsRef.doc(tweet.authorId).collection('userTweets').add({
//       'text': tweet.text,
//       'image': tweet.image,
//       "authorId": tweet.authorId,
//       "timestamp": tweet.timestamp,
//       'likes': tweet.likes,
//       'retweets': tweet.retweets,
//     }).then((doc) async {
//       QuerySnapshot followerSnapshot =
//           await followersRef.doc(tweet.authorId).collection('Followers').get();

//       for (var docSnapshot in followerSnapshot.docs) {
//         feedRefs.doc(docSnapshot.id).collection('userFeed').doc(doc.id).set({
//           'text': tweet.text,
//           'image': tweet.image,
//           "authorId": tweet.authorId,
//           "timestamp": tweet.timestamp,
//           'likes': tweet.likes,
//           'retweets': tweet.retweets,
//         });
//       }
//     });
//   }

//   static Future<List> getUserTweets(String userId) async {
//     QuerySnapshot userTweetsSnap = await tweetsRef
//         .doc(userId)
//         .collection('userTweets')
//         .orderBy('timestamp', descending: true)
//         .get();
//     List<Tweet> userTweets =
//         userTweetsSnap.docs.map((doc) => Tweet.fromDoc(doc)).toList();

//     return userTweets;
//   }

//   static Future<List> getHomeTweets(String currentUserId) async {
//     QuerySnapshot homeTweets = await feedRefs
//         .doc(currentUserId)
//         .collection('userFeed')
//         .orderBy('timestamp', descending: true)
//         .get();

//     List<Tweet> followingTweets =
//         homeTweets.docs.map((doc) => Tweet.fromDoc(doc)).toList();
//     return followingTweets;
//   }

//   // static void likeTweet(String currentUserId, Tweet tweet) {
//   //   DocumentReference tweetDocProfile =
//   //       tweetsRef.doc(tweet.authorId).collection('userTweets').doc(tweet.id);
//   //   tweetDocProfile.get().then((doc) {
//   //     int likes = doc.data().['likes'];
//   //     tweetDocProfile.update({'likes': likes + 1});
//   //   });

//   //   DocumentReference tweetDocFeed =
//   //       feedRefs.doc(currentUserId).collection('userFeed').doc(tweet.id);
//   //   tweetDocFeed.get().then((doc) {
//   //     if (doc.exists) {
//   //       int likes = doc.data()['likes'];
//   //       tweetDocFeed.update({'likes': likes + 1});
//   //     }
//   //   });

//   //   likesRef.doc(tweet.id).collection('tweetLikes').doc(currentUserId).set({});

//   //   addActivity(currentUserId, tweet, false, "");
//   // }

//   // static void unlikeTweet(String currentUserId, Tweet tweet) {
//   //   DocumentReference tweetDocProfile =
//   //       tweetsRef.doc(tweet.authorId).collection('userTweets').doc(tweet.id);
//   //   tweetDocProfile.get().then((doc) {
//   //     int likes = doc.data()['likes'];
//   //     tweetDocProfile.update({'likes': likes - 1});
//   //   });

//   //   DocumentReference tweetDocFeed =
//   //       feedRefs.doc(currentUserId).collection('userFeed').doc(tweet.id);
//   //   tweetDocFeed.get().then((doc) {
//   //     if (doc.exists) {
//   //       int likes = doc.data()['likes']??"";
//   //       tweetDocFeed.update({'likes': likes - 1});
//   //     }
//   //   });

//   //   likesRef
//   //       .doc(tweet.id)
//   //       .collection('tweetLikes')
//   //       .doc(currentUserId)
//   //       .get()
//   //       .then((doc) => doc.reference.delete());
//   // }

//   static Future<bool> isLikeTweet(String currentUserId, Tweet tweet) async {
//     DocumentSnapshot userDoc = await likesRef
//         .doc(tweet.id)
//         .collection('tweetLikes')
//         .doc(currentUserId)
//         .get();

//     return userDoc.exists;
//   }

//   static Future<List<Activity>> getActivities(String userId) async {
//     QuerySnapshot userActivitiesSnapshot = await activitiesRef
//         .doc(userId)
//         .collection('userActivities')
//         .orderBy('timestamp', descending: true)
//         .get();

//     List<Activity> activities = userActivitiesSnapshot.docs
//         .map((doc) => Activity.fromDoc(doc))
//         .toList();

//     return activities;
//   }

//   static void addActivity(
//       String currentUserId, Tweet tweet, bool follow, String followedUserId) {
//     if (follow) {
//       activitiesRef.doc(followedUserId).collection('userActivities').add({
//         'fromUserId': currentUserId,
//         'timestamp': Timestamp.fromDate(DateTime.now()),
//         "follow": true,
//       });
//     } else {
//       //like
//       activitiesRef.doc(tweet.authorId).collection('userActivities').add({
//         'fromUserId': currentUserId,
//         'timestamp': Timestamp.fromDate(DateTime.now()),
//         "follow": false,
//       });
//     }
//   }
// }
