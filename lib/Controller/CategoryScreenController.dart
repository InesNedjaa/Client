import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/Food.dart';
import '../View/Food_Search.dart';
import '../View/Restaurant.dart';
import '../Wrappers/wrapper2.dart';

class CategoryScreenController extends GetxController{

 List<Restaurant> restaurant = [] ;
 void categories_items (AsyncSnapshot snapshot ,List<Food_Search> food ){
   if(snapshot.hasData){
     for (Food plat in snapshot.data!) {
       int i = restaurant.indexWhere((element) => plat.resId == element.id);
       Restaurant resto = i != -1 ? restaurant[i] : restaurant[0];
       food.add(Food_Search(image: plat.image,
           name: plat.name,
           prix: plat.prix,
           description: plat.description,
           restaurant: resto));

   }}}
}