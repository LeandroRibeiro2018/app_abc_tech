import 'package:abc_tech_app/controller/geolacation_service.dart';
import 'package:abc_tech_app/model/assist.dart';
import 'package:abc_tech_app/model/order.dart';
import 'package:abc_tech_app/model/order_location.dart';
import 'package:abc_tech_app/service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

enum OrderState { creating, started, finish }

class OrderController extends GetxController {
  final GeolocationServiceInterface _geolocationService;
  final OrderServiceInterface _orderSevice;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();
  final selectedAssists = <Assist>[].obs;
  late Order _order;
  final screenState = OrderState.creating.obs;

  OrderController(this._geolocationService, this._orderSevice);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
  }

  getLocation() {
    _geolocationService
        .getPosition()
        .then((value) => log(value.toJson().toString()));
  }

  editAssist() {
    Get.toNamed("/services", arguments: selectedAssists);
  }

  finishStarOrder() {
    switch (screenState.value) {
      case OrderState.creating:
        _geolocationService.getPosition().then((value) {
          var start = OrderLocation(
              latitude: value.latitude,
              longitude: value.longitude,
              dateTime: DateTime.now());

          List<int> assists =
              selectedAssists.map((element) => element.id).toList();
          _order = Order(
              operatorId: int.parse(operatorIdController.text),
              services: assists);
          _order.start = start;
          screenState.value = OrderState.started;
        });
        break;
      case OrderState.started:
        _geolocationService.getPosition().then((value) {
          var end = OrderLocation(
              latitude: value.latitude,
              longitude: value.longitude,
              dateTime: DateTime.now());
          _order.end = end;
          screenState.value = OrderState.finish;
          _createOrder();
        });
        break;
      case OrderState.finish:
        break;
    }
  }

  void _createOrder() {
    _orderSevice.createOrder(_order).then((value) {
      if (value) {
        Get.snackbar("Sucesso", "Ordem criada com sucesso");
      } else {
        Get.snackbar("Error", "Problema ao criar ordem",
            backgroundColor: Colors.red);
      }
    }).onError((error, stackTrace) {
      ("Error", "Problema ao criar ordem", backgoundColor: Colors.red);
    });
  }
}
