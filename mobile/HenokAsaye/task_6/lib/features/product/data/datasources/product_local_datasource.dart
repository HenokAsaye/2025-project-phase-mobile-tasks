import 'package:task_6/features/product/data/models/product_model.dart';
abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}
