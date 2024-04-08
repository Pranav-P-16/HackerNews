import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/newuser.dart';

class APIs {
  static FirebaseAuth auth= FirebaseAuth.instance;
  static FirebaseFirestore firestore= FirebaseFirestore.instance;
  static User get user => auth.currentUser!;


  static Future<bool> userExists() async {
    return (await firestore.collection('users')
        .doc(user.uid)
        .get()).exists;
  }
  static Future<void> createUser() async {
    final time=DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser=NewUser(
        name: user.displayName.toString(),
        createdAt: time,
        id: user.uid,
        email: user.email.toString());

    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }
}