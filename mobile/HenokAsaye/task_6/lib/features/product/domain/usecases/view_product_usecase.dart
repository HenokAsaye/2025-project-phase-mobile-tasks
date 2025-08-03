import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/error/failures.dart';

class ViewProductUseCase {
  final ProductRepository repository;

  ViewProductUseCase(this.repository);

  Future<Either<Failure, Product>> call(String productId) {
    return repository.getProduct(productId);
  }
}