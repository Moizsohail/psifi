import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementation{
  Future<String> SignIn(String email,String password);
  Future<String> Register(String email,String password);
  Future<String> getCurrentUser();
  Future<void> signOut();
  Stream<FirebaseUser> onAuthStateChanged();
}
class Auth implements AuthImplementation{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<FirebaseUser>  onAuthStateChanged(){
    return _firebaseAuth.onAuthStateChanged;
  }
  Future<String> SignIn(String email,String password) async{
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email,password: password);
    return user.uid;
  }
  Future<String> Register(String email,String password) async{
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
    return user.uid;
  }
  Future<String> getCurrentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user == null){
      return null;
    }
    //print(user.uid);
    return user.uid;
  }
  Future<void> signOut() async{
    _firebaseAuth.signOut();
  }
}