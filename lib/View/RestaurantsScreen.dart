import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/View/Restaurant.dart';
import 'package:project/bdd/restauinfo.dart';

import '../Controller/RestaurantController.dart';
import '../Controller/Restaurants_controller.dart';


class RestaurantsScreen extends StatelessWidget {
   RestaurantsScreen({Key? key}) : super(key: key);

  Restaurants_controller controller = Get.put(Restaurants_controller(),permanent: true) ;
  @override
  Widget build(BuildContext context) {
    Get.put(RestaurantController()) ;
    return
     SafeArea(
        child:
              Scaffold(

                  body:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Positioned(
                        top: 10.h,
                        left: 13.w,
                        child: SizedBox(
                          height: 28.h,
                          width: 29.w,
                          child: FloatingActionButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                            backgroundColor: Color(0xffDFDFDF),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h,),

                      SizedBox(height:10.h) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 13.w,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: AutoSizeText(
                              'Restaurants',
                              maxLines: 1,
                              style: TextStyle(fontSize: 28.sp, fontFamily: 'Golos'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      GetBuilder<Restaurants_controller>(
                          builder: (controller){return
                            FutureBuilder<List<Restaurant>>(
                                future: RestauService().getRestaurantList() ,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    controller.restaurants = snapshot.data!;

                                  }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.restaurants.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        controller.restaurants[index],
                                        SizedBox(height: 30.w,)
                                      ],
                                    ) ;
                                  });
                            }
                          ); })
                    ],
                  )
              )
    )  ;
  }
}
