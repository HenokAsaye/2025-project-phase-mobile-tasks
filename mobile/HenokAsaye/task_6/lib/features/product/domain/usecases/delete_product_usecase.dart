import 'package:dartz/dartz.dart';
import '../repositories/product_repository.dart';
import '../../../../core/error/failures.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  Future<Either<Failure, void>> call(String productId) {
    return repository.deleteProduct(productId);
  }
}