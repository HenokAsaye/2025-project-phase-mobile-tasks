import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/error/failures.dart';

class ViewAllProductsUseCase {
  final ProductRepository repository;

  ViewAllProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call() {
    return repository.getAllProduct();
  }
}
