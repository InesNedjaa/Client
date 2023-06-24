
import 'package:project/View/Food_Search.dart';

import '../../View/Food.dart';

class categorie {
  final String nom_cat ;

  List<Food_Search> plat ;
  categorie( this.nom_cat,this.plat);
  bool operator == ( Object category) {
    return category is categorie && category.nom_cat == nom_cat ;

  }
}