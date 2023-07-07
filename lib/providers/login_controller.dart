
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class LoginController extends GetxController {
  showPasswordVisible();
}
class LoginControllerImplement extends LoginController{
  bool passwordVisible = true;
@override
    showPasswordVisible(){

      passwordVisible = !passwordVisible;
      update();

  }

}