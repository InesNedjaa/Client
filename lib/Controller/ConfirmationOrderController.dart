import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../View/OrderConfirmer.dart';
import '../bdd/clientinfo.dart';
import 'CartController.dart';
import 'package:intl/intl.dart';
class ConfirmationOrderController extends GetxController{
  final message = new TextEditingController();
  bool handle_button = false ;
  Future<void> confirm_command(user) async {
    String code =generate_num_command();

    CartController.commande.message=message.text;
    CartController.commande.date=DateFormat('dd-MM-yy').format(DateTime.now());
    CartController.commande.etat='En cours' ;
    await DatabaseService(uid: user!.uid).writeCommande(message.text ,code);
    await DatabaseService(uid: user!.uid).writecommandetouser(code);
    message.dispose() ;
    handle_button =true ;
    Get.off(OrderConfirmerScreen(id_commande: code,)) ;
    update();
  }
  String generate_num_command(){
    const char='0123456789';
    Random _rnd=Random();
    return String.fromCharCodes(Iterable.generate(5,(_)=> char.codeUnitAt(_rnd.nextInt(char.length))));
  }


}