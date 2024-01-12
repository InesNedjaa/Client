
import 'package:flutter/cupertino.dart';
import 'package:project/View/LoginScreen.dart';
import 'package:project/View/SplashScreen.dart';
import 'package:provider/provider.dart';
import '../Controller/AppController.dart';
import '../View/currentPage.dart';
import '../auth/auth.dart';
import '../auth/user.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return StreamProvider<MyUser?>.value(
        value: AuthService().user,
        initialData: MyUser(uid: "", phone: null),
        catchError: (e, i) => null,

        builder: (context, widget)  {

          AppController.user = Provider.of<MyUser?>(context);

          if (AppController.user != null && AppController.user ?.uid != "") {
            return Main_Page();
          }

          else if (AppController.user == null  )
              return SplashScreen();

             else return Container();

        });
  }
}
