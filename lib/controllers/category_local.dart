
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pos_system_ui/controllers/product_local.dart';
import 'package:pos_system_ui/models/categorymodel.dart';
import 'service_controller.dart';

class category_local extends GetxController{
  var categories = <Category_local>[].obs;
  var selectedCategoryId = 0.obs;
  final productService = Get.put(service_controller());
  final productController=Get.put(product_local());
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
  void fetchCategories(){
    categories.assignAll(productService.fetchCategories());
    if (categories.isNotEmpty) {
      selectedCategoryId.value = categories[0].id;
      fetchProducts(selectedCategoryId.value);
    }
  }
  void fetchProducts(int categoryId) {
    productController.products.assignAll(productService.fetchProducts(categoryId));
  }
  void onCategorySelected(int categoryId) {
    print(categoryId);
    selectedCategoryId.value = categoryId;
    fetchProducts(categoryId);
  }
}