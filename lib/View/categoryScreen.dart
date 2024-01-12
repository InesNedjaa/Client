import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/View/Food.dart';
import 'package:project/bdd/restauinfo.dart';
import 'package:shimmer/shimmer.dart';
import '../Controller/CategoryScreenController.dart';
import '../Controller/RestaurantController.dart';
import '../Controller/Restaurants_controller.dart';
import '../Themes/Theme.dart';
import '../Wrappers/wrapper2.dart';
import 'Food_Search.dart';
import 'Restaurant.dart';


class CategoryScreen extends StatelessWidget {
  final String category_name,id ;
  CategoryScreen({Key? key, required this.category_name, required this.id}) : super(key: key);

  CategoryScreenController controller = Get.put(CategoryScreenController()) ;

  @override
  Widget build(BuildContext context) {


          return
            SafeArea(
              child: Scaffold(
                  body:
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 25.h,),
                        Padding(
                          padding:  EdgeInsets.only(top: 10.h , left : 13.w),
                          child: SizedBox(
                            height: 28.h,
                            width: 29.w,
                            child: FloatingActionButton(
                              foregroundColor:  Color(0xffDFDFDF) ,
                              onPressed: () {
                                Get.back() ;
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
                        SizedBox(height:10.h) ,
                        Row(
                          children: [
                            Spacer(flex: 14,),
                            Expanded(
                              flex: 400,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AutoSizeText(
                                  '$category_name',
                                  maxLines: 1,
                                  style: theme().textTheme.headline1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),

                              FutureBuilder<List<Food>>(
                                  future: RestauService().getFoodListByCategory(id),
                                  builder: (context, snapshot) {
                                    List<Food_Search> food = <Food_Search>[];
                                     controller.categories_items(snapshot , food);
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: food.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          SizedBox(width: 15.w,),
                                          Container(
                                            height: 270.h,
                                            width:281.w ,
                                            child: food[index] ,
                                          ),
                                          // Spacer(flex: 14,)
                                        ],
                                      ) ;
                                    });
                              }
                            )
                      ],
                    ),
                  )
              )
          );

  }

}
