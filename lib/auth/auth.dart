import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/View/LoginScreen.dart';
import 'package:project/auth/user.dart';


class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference livreurCollection = FirebaseFirestore.instance.collection('livreur');
  // convert FirebaseUser to MyUser
  MyUser? _useFromFireBaseUser(User? user){
    if (user != null) {
      return MyUser(uid: user.uid,phone: user.phoneNumber );
    } else {
      return null;
    }
  }
  // auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map((user) => _useFromFireBaseUser(user));

  }
// signe out
  Future singeOut() async {
    try{

      Get.offAll(LoginScreen());
      return await _auth.signOut();


    }catch(e){
      return null ;
    }
  }



}