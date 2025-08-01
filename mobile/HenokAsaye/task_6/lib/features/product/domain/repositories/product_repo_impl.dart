import '../entities/Product.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository{
  final List<Product> _products = [];

  @override
  Future<void> createProduct(Product product) async{
    _products.add(product);
  }


  @override
  Future<List<Product>> getAllProduct() async{
    return _products;
  }


  @override
  Future<Product> getProductById(String id) async{
    return _products.firstWhere((p) => p.id == id);
  }


  @override
  Future<void> deleteProduct(String id) async {
    return _products.removeWhere((p) => p.id == id);
  }

  @override
  Future<void>updateProduct(Product product) async{
    final index = _products.indexWhere((p) => p.id == product.id);
    if(index !=-1){
      _products[index] = product;
    }
  }
}