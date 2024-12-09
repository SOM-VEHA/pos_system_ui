import 'package:get/get.dart';
import 'package:pos_system_ui/models/productmodel.dart';
class farvorite_local extends GetxController{
  var favorites = <Product_local>[].obs;
  List<Product_local> get _favorites => favorites;
  void toggleFavorite(Product_local product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
  }
  bool isExist(Product_local product) {
    final isExist = _favorites.contains(product);
    return isExist;
  }
}