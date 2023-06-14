



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/Food.dart';
import '../View/Restaurant.dart';
import '../classes/OpenTime.dart';
import '../classes/promotion.dart';
import 'classes.dart';

class RestauService {
static String plasImage = "", foodImage = "", name = "";
static List<Food> List_of_food =[];
final CollectionReference restauCollection =
FirebaseFirestore.instance.collection('Restaurant');

////////////////////////////////////////////////////////////////


List<Promotion> _promotion(QuerySnapshot snapshot) {
return snapshot.docs.map((doc) {
return Promotion(
image: doc.get("pic").toString(),
nameRestaurant: doc.get("name").toString(),
offre: doc.get("offre").toString(),
descriptionOffre: doc.get("descOffre").toString(),
ResId:  doc.get("ResId"),);
}).toList();
}

Stream<List<Promotion>> get promotion {
return FirebaseFirestore.instance
    .collection('Promotion')
    .snapshots()
    .map((snapshot) => _promotion(snapshot));
}

////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////

Future<List<Food>> getCategoreList(String uid, String categorie) async {
QuerySnapshot snapshot = await restauCollection.doc(uid).collection(categorie).get();
return _categoreList(snapshot);
}

Future<List<String>> getTabCate(String id) async {
DocumentSnapshot snapshot = await restauCollection.doc(id).get();
return _tabcate(snapshot);
}

List<Food> _categoreList(QuerySnapshot snapshot) {
return snapshot.docs.map((doc) {
return Food(
id: doc.get("ID").toString(),
name: doc.get("nom").toString(),
resId: doc.get("ResId").toString(),
prix: doc.get("prix").toDouble(),
categore: doc.get("categorie").toString(),
image: doc.get("ImageUrl").toString(),
ajouter: false.obs,
description: doc.get("description").toString(),
nom_restaurant: doc.get("Resname").toString(),
);
}).toList();
}

List<String> _tabcate(DocumentSnapshot snapshot) {
var t = snapshot.get("Categories");

List<String> z = [];
for (int i = 0; i < t.length; i++) {
z.add(t[i].toString());
}
return z;
}



String nom(String id) {
restauCollection.doc(id).get().then((value) => name = value.get("nom"));

return name;
}
writeCommande() async {


await FirebaseFirestore.instance
    .collection('Client')
    .add({
"nom":'' ,
"description":'' ,
"prix": 0,
"ID":' ',
"ResId": 'bgxt0iCCvObcRvpNVsXz',
"categorie":'Pizzas',


});

}


///////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////
List<Promotion> _promoListo(QuerySnapshot snapshot) {
return snapshot.docs.map((doc) {

return Promotion(
image: doc.get("pic").toString(),
nameRestaurant: doc.get("name").toString(),
offre: doc.get("offre").toString(),
descriptionOffre: doc.get("descOffre").toString(), ResId:  doc.get("ResId"),);
}).toList();
}

Stream<List<Promotion>> get promoList {
return  FirebaseFirestore.instance.collection('Promotion')
    .snapshots()
    .map((snapshot) => _promoListo(snapshot));
}

////////////////////////////////////////////////////////////////


///////////////////////////////////////

Future<List<cat>> getCatList() async {
QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Categories').get();
return _catList(snapshot);
}

List<cat> _catList(QuerySnapshot snapshot) {
return snapshot.docs.map((doc) {
return cat(id: doc.id, nom: doc.get("nom"));
}).toList();
}

Future<List<Restaurant>> getRestaurantList() async {
QuerySnapshot snapshot = await restauCollection.get();
return _restaurant2List(snapshot);
}

List<Restaurant> _restaurant2List(QuerySnapshot snapshot) {
return snapshot.docs.map((doc) {
DateTime opentime = DateTime.fromMillisecondsSinceEpoch(doc.get("closeTime").nanoseconds * 1000);
DateTime closetime = DateTime.fromMillisecondsSinceEpoch(doc.get("openTime").nanoseconds * 1000);
OpenTime open = OpenTime(TimeOfDay.fromDateTime(closetime), TimeOfDay.fromDateTime(opentime));

return Restaurant(
image: doc.get("ImageUrl").toString(),
name: doc.get("nom").toString(),
longitude: doc.get("Longitude").toDouble(),
latitude: doc.get("Latitude").toDouble(),
id: doc.get("ID").toString(),
adress: doc.get("Adress").toString(),
state: doc.get("state"),
openTime: open,
);
}).toList();
}



////

Future<List<Food>> getFoodList() async {
QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Plats').get();
return _foodList(snapshot);
}

Future<List<Food>> getFoodListByCategory(String categoryUid) async {
QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Categories').doc(categoryUid).collection("plats").get();
return _foodList(snapshot);
}

List<Food> _foodList(QuerySnapshot snapshot) {
return snapshot.docs.map((doc) {
return Food(
id: doc.get("ID").toString(),
name: doc.get("nom").toString(),
resId: doc.get("ResId").toString(),
prix: doc.get("prix").toDouble(),
categore: doc.get("categorie").toString(),
image: doc.get("ImageUrl").toString(),
ajouter: false.obs,
description: doc.get("description").toString(),
nom_restaurant: doc.get("Resname").toString(),
);
}).toList();
}

}
// 11 fonction
