
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/View/Food_Search.dart';
import 'package:project/classes/OpenTime.dart';
import '../View/Food.dart';
import '../View/Restaurant.dart';
import '../Wrappers/wrapper2.dart';
import '../classes/categorie.dart';




class SearchController extends GetxController {
  List<Restaurant> lo=[];
  List<categorie> categoriesResult=[];
  List<categorie> food=<categorie>[];
  List<categorie> food_result=[];
  RxString input_value ="".obs ;
  final input=TextEditingController();
  void sug() {
    List<Restaurant> l = [];
    print(Wrapper2.list.length);
    for (Restaurant i in Wrapper2.list) {
      if (i.name.toLowerCase().contains(input.text.toLowerCase())) {
        l.add(i);
      }
    }


    lo=l;


    update();
  }
  void remplir(AsyncSnapshot snapshot , String nom_categorie )  {

    if (snapshot.hasData){
      categorie category=categorie(nom_categorie, []);
      for ( Food plat in snapshot.data!){
        int i = Wrapper2.list.indexWhere((element) => plat.resId == element.id) ;
        Restaurant resto = i != -1 ? Wrapper2.list[i] : Wrapper2.list[0] ;
        print(i) ;
        category.plat.add(Food_Search(image: plat.image, name: plat.name, prix: plat.prix, description: plat.description, restaurant: resto));
      }
//      category.plat=snapshot.data!;
      !food.contains(category) ? food.add(category) :null;
    }


  }
  void sug2(  ) {
    food_result=[];
    for (categorie category in food) {
      categorie cat = categorie(category.nom_cat, []);
      for(Food_Search food in category.plat){
        if(food.name.toLowerCase().contains(input.text.toLowerCase())) {
          cat.plat.add(food);
        }
      }
      cat.plat.isNotEmpty ? food_result.add(cat) : null ;
    }

    update();
  }




}
