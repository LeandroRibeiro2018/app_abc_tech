import 'package:abc_tech_app/controller/assistance_contoller.dart';
import 'package:abc_tech_app/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class HomePage extends GetView<AssistanceController>{
  const HomePage({super.key});

  Widget _renderAssists(List<Assist> assists){
    return ListView.builder(
      shrinkWrap: ,
      itemCount: assists.length,
      itemBuilder:(contex, index) =>
      ListTile(title: Text(assists[index].title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ABC tech App")),
      body: Center(
        child: TextButton(
          onPressed: controller.getAssistanceList,
          child: Text("Carregar")),
      )
    );
  }

  
}