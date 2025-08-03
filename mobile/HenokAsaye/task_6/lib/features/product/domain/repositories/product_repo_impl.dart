import 'package:dartz/dartz.dart';
import 'package:task_6/features/product/data/datasources/product_local_datasource.dart';
import 'package:task_6/features/product/data/datasources/product_remote_datasource.dart';
import 'package:task_6/features/product/data/models/product_model.dart';
import 'package:task_6/core/network/network_info.dart';
import 'package:task_6/core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> createProduct(Product product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      if (await networkInfo.isConnected) {
        await remoteDataSource.createProduct(productModel);
        final allProducts = await remoteDataSource.fetchAllProducts();
        await localDataSource.cacheProducts(allProducts);
        return const Right(null);
      } else {
        return const Left(NetworkFailure());
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProduct() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteProducts = await remoteDataSource.fetchAllProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts.map((model) => model.toEntity()).toList());
      } else {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts.map((model) => model.toEntity()).toList());
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final model = await remoteDataSource.fetchProductById(id);
        return Right(model.toEntity());
      } else {
        return const Left(NetworkFailure());
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    try {
      if (await networkInfo.isConnected) {
        final model = ProductModel.fromEntity(product);
        await remoteDataSource.updateProduct(model);
        final allProducts = await remoteDataSource.fetchAllProducts();
        await localDataSource.cacheProducts(allProducts);
        return const Right(null);
      } else {
        return const Left(NetworkFailure());
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.deleteProduct(id);
        final updated = await remoteDataSource.fetchAllProducts();
        await localDataSource.cacheProducts(updated);
        return const Right(null);
      } else {
        return const Left(NetworkFailure());
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
