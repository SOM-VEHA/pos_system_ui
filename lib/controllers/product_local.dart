import 'package:get/get.dart';
import 'package:pos_system_ui/controllers/service_controller.dart';
import 'package:pos_system_ui/models/productmodel.dart';
class product_local extends GetxController{
  var products = <Product_local>[].obs;
  final productService = Get.put(service_controller());
  void fetchProducts(int categoryId) {
    print(categoryId);
    products.assignAll(productService.fetchProducts(categoryId));
  }
}