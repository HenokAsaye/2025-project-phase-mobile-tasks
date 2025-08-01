import '../entities/Product.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase {
  final ProductRepository repository;

  ViewAllProductsUsecase(this.repository);

  Future<List<Product>> call(){
    return repository.getAllProduct();
  }
}
