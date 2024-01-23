import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;

final usersRef = fireStore.collection('users');

final followersRef = fireStore.collection('followers');
final followingRef = fireStore.collection('following');
final activitiesRef = fireStore.collection('activities');
final tweetsRef = fireStore.collection('tweets');

final feedRefs = fireStore.collection('feeds');

final likesRef = fireStore.collection('likes');
