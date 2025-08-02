import 'package:task_6/features/product/data/datasources/product_local_datasource.dart';
import 'package:task_6/features/product/data/datasources/product_remote_datasource.dart';
import 'package:task_6/features/product/data/models/product_model.dart';
import 'package:task_6/core/network/network_info.dart';
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
  Future<void> createProduct(Product product) async {
    final productModel = ProductModel.fromEntity(product);
    if (await networkInfo.isConnected) {
      await remoteDataSource.createProduct(productModel);
      final allProducts = await remoteDataSource.fetchAllProducts();
      await localDataSource.cacheProducts(allProducts);
    } else {
      throw Exception('No Internet Connection');
    }
  }

  @override
  Future<List<Product>> getAllProduct() async {
    if (await networkInfo.isConnected) {
      final remoteProducts = await remoteDataSource.fetchAllProducts();
      await localDataSource.cacheProducts(remoteProducts);
      return remoteProducts.map((model) => model.toEntity()).toList();
    } else {
      final localProducts = await localDataSource.getCachedProducts();
      return localProducts.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      final model = await remoteDataSource.fetchProductById(id);
      return model.toEntity();
    } else {
      throw Exception('No Internet Connection');
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      final model = ProductModel.fromEntity(product);
      await remoteDataSource.updateProduct(model);
      final allProducts = await remoteDataSource.fetchAllProducts();
      await localDataSource.cacheProducts(allProducts);
    } else {
      throw Exception('No Internet Connection');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.deleteProduct(id);
      final updated = await remoteDataSource.fetchAllProducts();
      await localDataSource.cacheProducts(updated);
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
