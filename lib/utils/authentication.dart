import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/services.dart';

abstract class AuthImplementation{
  Future<String> signIn(String email,String password); //log in function, returns user's uid string
  Future<String> signUp(String email,String password); //register/sign up function, returns user's uid string
  Future<String> getCurrentUserUID(); //get current user UID string
  Future<void> signOut(); // log out function
  Stream<FirebaseUser> onAuthStateChanged();
}

class Auth implements AuthImplementation{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; //FirebaseAuth object created
  
  Stream<FirebaseUser>  onAuthStateChanged(){
    return _firebaseAuth.onAuthStateChanged;
  }
  
  Future<String> signIn(String _email,String _pass) async{
    //given email & password returns the FirebaseUser on signIn
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: _email, password: _pass);
    return user.uid;
  }

  Future<String> signUp(String _email,String _pass) async{
    //on registration/signUp, User created for given email and password, uid returned
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: _email, password: _pass);
    return user.uid;
  }
  
  Future<String> getCurrentUserUID() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user == null)  return null; //current session user does not exist, then null returned, else current user's uid
    return user.uid;
  }

  Future<void> signOut() async{
    _firebaseAuth.signOut();
  }
}