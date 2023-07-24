
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../Widgets/customDialog.dart';
import '../Widgets/customWithButtonDialog.dart';


class AppController extends GetxController{


  static void showDialogButton(String title, String ligne1, String ligne2, String asset, void Function() function) async {
    Get.dialog(
      customWithButtonDialog(
        fonction: () => function,
        title: title,
        ligne1: ligne1,
        ligne2: ligne2,
        asset: asset,
      ),
      barrierDismissible: true,
    );
  }

  static void showDialogLogin(ligne1, ligne2) async {
    Get.dialog(
      customDialog(
        title: 'S\'il vous plaît, attendez',
        ligne1: ligne1,
        ligne2: ligne2,
        asset: 'assets/json/sending.json',
      ),
      barrierDismissible: false,
    );
  }
  static void showDialog() async {
    Get.dialog(
      customDialog(
        title: 'Désoler',
        ligne1: 'Vous ne pouvez pas commander de deux restaurants différents',
        ligne2: '',
        asset: 'assets/json/exclamation.json',
      ),
      barrierDismissible: true,
    );
  }
}


