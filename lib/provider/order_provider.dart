import 'package:abc_tech_app/constants.dart';
import 'package:abc_tech_app/model/order.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

abstract class OrderProviderInterface {
  Future<Response> postOrder(Order order);
}

class OrderProvider extends GetConnect implements OrderProviderInterface {
  @override
  Future<Response> postOrder(Order order) =>
      post('${Constants.url}/order', order.toMap());
}
