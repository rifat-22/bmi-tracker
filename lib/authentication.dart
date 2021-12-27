import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth =
      FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp(
      {String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn(
      {String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

  //data store method

  Future<void> storeBmi(
      double bmiValue, String date) async {
    final CollectionReference bmiCollection =
        FirebaseFirestore.instance
            .collection('/bmis');
    print('hello');

    return await bmiCollection
        .doc("bmidata")
        .set({
      "$date": {
        "bmi": bmiValue,
        "user_uid": user.uid,
        "date": date,
      },
    }, SetOptions(merge: true));
  }

  Future<String> getBmi(
      BuildContext context) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance
            .collection('bmis');

    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) => doc.data())
        .toList();
    // print(allData);

    print('baaa');

    print(allData.length);
    return allData.toString();
  }
}
