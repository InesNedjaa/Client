
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controller/AppController.dart';
import 'package:project/View/OTPScreen.dart';
import 'package:url_launcher/url_launcher.dart';



class LoginScreenController extends GetxController {
  bool hasInternet=false;
  bool codeIsComing=true;
  final phoneNumber= new TextEditingController();
  static final  nom= new TextEditingController();
  bool submit1=false;
  bool submit2=false;
  final Uri _number = Uri.parse('tel:+213556000010');

  static String verificationCode='';



  void onSubmitLogin() {
    submit1=phoneNumber.text.length==9;
    submit2=nom.text.isNotEmpty;
    update();
  }

  void onInDirectCall()async {
    if (!await launchUrl(_number))
      throw 'Could not launch $_number';
    update();
  }
  void createNewUser(String numTel,String nom)async {




  }
  Future signInWithPhoneNumber() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+213${phoneNumber.text}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            print('goooooooooooooooooood');
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {

            });
          },
          verificationFailed: (FirebaseException e) {

            AppController.showDialogButton('le code de vérification est erroné',
                'votre code est erroné, veuillez ajouter', 'un code valide',
                'assets/json/exclamation.json', () {
                  Get.back();
                });

          },
          codeSent: (String verifictaionID, int? resendToken) {

            Get.to(OTPScreen(phoneNumber: phoneNumber.text));
            verificationCode = verifictaionID;
            phoneNumber.clear();

          },
          codeAutoRetrievalTimeout: (String verifictaionID) {
            verificationCode = verifictaionID;
          },
          timeout: Duration(seconds: 60));
    } catch (e) {

    }
  }


}