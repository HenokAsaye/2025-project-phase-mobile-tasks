import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/error/failures.dart';

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  Future<Either<Failure, void>> call(Product product) {
    return repository.updateProduct(product);
  }
}