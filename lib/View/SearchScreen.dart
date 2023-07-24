import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:provider/provider.dart';
import '../Controller/LoginScreenController.dart';
import '../Controller/SearchController.dart' as search;

import '../Themes/Theme.dart';
import '../Wrappers/wrapper2.dart';
import '../auth/user.dart';
import '../bdd/clientinfo.dart';
import '../bdd/restauinfo.dart';
import 'Food.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  List<Food> foodOneCategory =[];
  List<Food> plat =[];
  search.SearchController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 39.h,),
              Row(
                children: [
                  SizedBox(
                    width: 13.w,
                  ),
                  StreamBuilder<String>(
                      stream: DatabaseService(uid: user!.uid).Lenom,
                      builder: (context, snapshot) {
                        RxString nom ="".obs ;
                        if (snapshot.hasData){
                          nom.value=snapshot.data!;

                        }
                        return AutoSizeText(
                            'Salut ${nom.value},\nBienvenue dans notre magasin !',
                            style: theme().textTheme.bodyText1?.copyWith(color: Colors.black)
                        );
                      }
                  ),
                ],
              ),
              SizedBox(height: 26.h,),
              Row(
                  children: [
                    SizedBox(
                      width: 13.w,
                    ),
                    Container(
                      height: 56.h,
                      width: 401.w,
                      child: TextField(
                        onChanged: (value){
                          controller.input_value.value=value;
                         if( value !="" )
                           {
                             controller.sug( ) ;

                          controller.sug2(); }

                        },
                        controller: controller.input,
                        textAlign: TextAlign.left,
                        cursorColor: Colors.grey,
                        enabled: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(EvaIcons.search, color: Color(0xff9D9D9D)),
                          hintText: 'Trouvez votre restaurant, votre produit',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.h,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.r),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor:  Color(0xffF6F6F6),
                        ),

                      ),
                    ),
                  ]
              ),
              SizedBox(height: controller.lo.length != 0 ? 24.h:0,),
             GetX<search.SearchController>(
               builder: (controller) {
                 return
                   controller.input_value.value!= "" ?
                       Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<search.SearchController>(
                          builder: (controller) {
                            return Row(
                              children: [
                                SizedBox(width: 13.w,),
                                controller.lo.length != 0 ? AutoSizeText( 'Restaurant',
                                    style:theme().textTheme.headline4

                                ) : Container() ,
                              ],
                            );
                          }
                      ),
                      SizedBox(height: controller.lo.length != 0 ?17.h:0,),
                      GetBuilder<search.SearchController>(
                        builder:(controller) {
                          return
                            Container(
                                height:controller.lo.length != 0 ? 290.h :0,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:controller.lo.length ,
                                    itemBuilder: (context, index) => Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 13.w,),
                                        Container(
                                            height: 310.h,
                                            width: 389.w,
                                            child: controller.lo[index])
                                      ],
                                    )));
                        },
                      ),

                      GetBuilder<search.SearchController>(
                          builder: (controller) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: Wrapper2.list2.length,
                                itemBuilder: (context, index2) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 10.w,) ,
                                      FutureBuilder<List<Food>>(
                                          future: RestauService().getFoodListByCategory(Wrapper2.list2[index2].id),
                                          builder: (context, snapshot) {
                                            controller.remplir(snapshot,Wrapper2.list2[index2].nom);

                                            return Container();
                                          }
                                      ) ,
                                    ],
                                  );

                                });
                          }
                      ),
                      GetBuilder<search.SearchController>(
                          builder: (controller) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.food_result.length,
                              itemBuilder: (context , index4) =>Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        SizedBox(width:13.w) ,
                                        AutoSizeText(
                                          controller.food_result[index4].nom_cat,
                                          style:theme().textTheme.headline4 , textAlign: TextAlign.start,
                                        ) , ]),
                                  SizedBox(height: 17.h,),
                                  Container(
                                    height : 220.h ,
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount : controller.food_result[index4].plat.length,
                                        itemBuilder: (context , index3) {

                                          return Row(

                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 13.w,) ,
                                              Container(
                                                height: 220.h ,
                                                width:281.w ,
                                                child:
                                                controller.food_result[index4].plat[index3],
                                              )

                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            );
                          }
                      )
                    ],
                  ):Container();
               }
             ),


            ],
          ),
        ),
      ),
    );
  }
}
