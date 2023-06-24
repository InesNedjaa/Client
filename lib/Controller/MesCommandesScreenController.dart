import 'package:get/get.dart';

import '../bdd/classes.dart';



class MesCommandesScreenController extends GetxController{

  RxList<MaCommande>command=<MaCommande>[].obs;
  double coutPartiel(List<Maplat> plats){
    double somme=0;
    for(int i=0;i<plats.length;i++){
      somme=somme+plats[i].prix;
    }
    return somme;
  }
  double coutTotal(List<Maplat> plats){
    return coutPartiel(plats)+500;
  }
  /*@override
  String toString(){
    return this.date+' '+this.etat;
  }*/
  @override
  void onInit() {
    //archiveCurrentCommand();
    super.onInit();
  }
}