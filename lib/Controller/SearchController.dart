import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../View/Food.dart';
import '../View/Restaurant.dart';
import '../Wrappers/wrapper2.dart';
import '../classes/categorie.dart';

class SearchController extends GetxController {
  RxList<Restaurant> lo = <Restaurant>[].obs;
  RxList<categorie> categoriesResult = <categorie>[].obs;
  List<categorie> food = <categorie>[];
  RxList<categorie> food_result = <categorie>[].obs;
  final input = TextEditingController();

  void sug() {
    RxList<Restaurant> l = <Restaurant>[].obs;
    print(Wrapper2.list.length);
    for (Restaurant i in Wrapper2.list) {
      if (i.name.toLowerCase().contains(input.text.toLowerCase())) {
        l.add(i);
      }
    }

    lo = l;
    update();
  }

  void remplir(AsyncSnapshot snapshot, String nom_categorie) {
    if (snapshot.hasData) {
      categorie category = categorie(nom_categorie, []);
      category.plat = snapshot.data!;
      if (!food.contains(category)) {
        food.add(category);
      }
    }
  }

  void sug2() {
    food_result = <categorie>[].obs;
    for (categorie category in food) {
      categorie cat = categorie(category.nom_cat, []);
      for (Food food in category.plat) {
        if (food.name.toLowerCase().contains(input.text.toLowerCase())) {
          cat.plat.add(food);
        }
      }
      if (cat.plat.isNotEmpty) {
        food_result.add(cat);
      }
    }

    update();
  }

  @override
  void onClose() {
    input.dispose();
    super.onClose();
  }
}
