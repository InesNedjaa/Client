

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/bdd/clientinfo.dart';
import 'package:provider/provider.dart';

import '../Controller/LoginScreenController.dart';
import '../View/currentPage.dart';
import '../auth/user.dart';


class AdresseScreenController extends GetxController{

  bool submitAdresse=false;
  final Adresse= new TextEditingController();

  void onSubmitAdresse() {
    submitAdresse=Adresse.text.isNotEmpty;
    update();
  }


void addAdresseUser(String adresse){


}


  @override
  void onClose() {

    super.onClose();
  }
}