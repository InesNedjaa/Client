
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
          verificationFailed: (FirebaseException error) {
            switch (error.code) {
              case "invalid-phone-number":
                AppController.showDialogButton('Numéro de téléphone incorrect',
                    'votre numéro de téléphone est erroné, veuillez ajouter', 'un numéro de téléphone  valide',
                    'assets/json/exclamation.json', () {
                      Get.back;
                    });
                break;
              case "missing-phone-number":
                AppController.showDialogButton('Numéro de téléphone incorrect',
                    'votre numéro de téléphone est erroné, veuillez ajouter', 'un numéro de téléphone  valide',
                    'assets/json/exclamation.json', () {
                      Get.back;
                    });
                break;
              case "too-many-requests":
                AppController.showDialogButton('Votre compte est blocké',
                    'votre compte est blocké, veuillez contacter', 'notre service',
                    'assets/json/exclamation.json', () {
                      Get.back;
                    });
                break;






              default:
                AppController.showDialogButton('Une erreur se produite',
                    'Veuillez vérifier votre connexion', '',
                    'assets/json/exclamation.json', () {
                      Get.back;
                    });
            }

            print("why verification is failed ???????????????????????????????????????????${error.code}");
            print(error);

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
    update();
  }


}