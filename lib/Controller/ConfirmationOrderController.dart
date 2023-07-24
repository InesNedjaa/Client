import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/lifecycle.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../View/OrderConfirmer.dart';
import '../bdd/clientinfo.dart';
import 'CartController.dart';
import 'package:intl/intl.dart';
class ConfirmationOrderController extends GetxController{
  final message = new TextEditingController();

  Future<void> confirm_command(user) async {
    CartController.commande.numero_commande=generate_num_command();
    CartController.commande.message=message.text;
    CartController.commande.date=DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
    CartController.commande.etat='En cours' ;
    await DatabaseService(uid: user!.uid).writeCommande(message.text );
    await DatabaseService(uid: user!.uid).writecommandetouser();
    message.dispose() ;
    Get.off(OrderConfirmerScreen(id_commande: CartController.commande.numero_commande,)) ;
    update();
  }
  String generate_num_command(){
    const char='0123456789aAzZeErRtTyYuUiIoOpPqQsSdDfFgGhHjJkKlLmMwWxXcCvVbBnN';
    Random _rnd=Random();
    return String.fromCharCodes(Iterable.generate(9,(_)=> char.codeUnitAt(_rnd.nextInt(char.length))));
  }


}