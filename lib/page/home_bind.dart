import 'package:abc_tech_app/controller/assistance_contoller.dart';
import 'package:get/get.dart';

class HomeBind extends Bindings {

  void dependencies(){
    Get.lazyPut(() => AssistanceController());
  }
}