import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AuthService {

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  ///UPDATE USER PROFILE
  static Future<bool> setProfile (
      {required String fName,
        required String lName,
        required String phone,
        required String email,
        required String password})

  async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('users').doc(email).set({
      "firstname": fName,
      "lastName": lName,
      "phone": phone,
      "email": email,
      "password": password,
      // "profileImage": imageUrl
    });
    return true;
  }


  ///CHECK EMAIL ADDRESS - IF IT EXISTS IN THE DATABASE OR NOT
  static Future<int> checkIfUserIsRegistered({
    required String email
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var res = await firebaseFirestore
        .collection('users')
        .where("email", isEqualTo: email)
        .get();

    return res.docs.length;
  }

  ///UPDATE USER PROFILE
  static Future<bool> setTicket (
      {required String title,
        required String description,
        // required String phone,
        required String email,
        // required String password
      })

  async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('users').doc(email).collection('tickets').doc().set({
      "title": title,
      "description": description,
      // "phone": phone,
      // "email": email,
      // "password": password,
      // "profileImage": imageUrl
    });
    return true;
  }

}
