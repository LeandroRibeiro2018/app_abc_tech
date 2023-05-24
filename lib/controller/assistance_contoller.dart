import 'package:abc_tech_app/service/assist_service.dart';
import 'package:get/get.dart';

import '../model/assist.dart';

class AssistanceController extends GetxController 
with StateMixin<List<Assist>>{

  late AssistanceService _assistanceService;

  void onInit(){
    super.onInit();
    _assistanceService = Get.find<AssistanceService>();
  }

  void getAssistanceList(){
    _assistanceService
    .getAssists()
    .then((value) => change (value, status: RxStatus.success()))
    .onError((error, stackTrace) => change([], status: RxStatus.error()));
  }

}