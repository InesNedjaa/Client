
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../View/Restaurant.dart';
import '../../View/SearchScreen.dart';
import '../Controller/SearchController.dart';
import '../bdd/classes.dart';
import '../bdd/restauinfo.dart';


class Wrapper2 extends StatelessWidget {
   Wrapper2({Key? key}) : super(key: key);
  static   List<cat> list2 =[];
  static List<Restaurant> list = [];
  SearchController controller = Get.put(SearchController() , permanent: true);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Restaurant>>(
        future: RestauService().getRestaurantList() ,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            list = snapshot.data!;

          }

          return FutureBuilder<List<cat>>(
              future: RestauService().getCatList(),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  list2 = snapshot.data! ;

                //SearchScreen.li=list2.obs;
                return  SearchScreen();
              }
          );
        });
  }
}
