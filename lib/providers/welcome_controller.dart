
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/routes.dart';

abstract class WelcomeController extends GetxController {
}
class WelcomeControllerImplement extends WelcomeController{
  final Future<SharedPreferences> _prefs  = SharedPreferences.getInstance();
  String supplierId='';
  @override
  void onInit() {
    _prefs.then((SharedPreferences prefs) {
      return prefs.getString('supplierid') ??'';
    }).then((String value) {

      supplierId=value;
    if(supplierId !=''){
      Get.offAllNamed(AppRoutes.supplierHomeScreen);
    }

    });

    super.onInit();

  }




}