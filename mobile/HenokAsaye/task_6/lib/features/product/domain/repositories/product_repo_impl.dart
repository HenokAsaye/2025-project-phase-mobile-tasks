import 'package:task_6/features/product/data/datasources/product_local_datasource.dart';
import 'package:task_6/features/product/data/datasources/product_remote_datasource.dart';
import 'package:task_6/features/product/data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<void> createProduct(Product product) async {
    final productModel = ProductModel.fromEntity(product);
    await remoteDataSource.createProduct(productModel);
    final allProducts = await remoteDataSource.fetchAllProducts();
    await localDataSource.cacheProducts(allProducts);
  }

  @override
  Future<List<Product>> getAllProduct() async {
    try {
      final remoteProducts = await remoteDataSource.fetchAllProducts();
      await localDataSource.cacheProducts(remoteProducts);
      return remoteProducts.map((model) => model.toEntity()).toList();
    } catch (e) {
      final localProducts = await localDataSource.getCachedProducts();
      return localProducts.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    final model = await remoteDataSource.fetchProductById(id);
    return model.toEntity();
  }

  @override
  Future<void> updateProduct(Product product) async {
    final model = ProductModel.fromEntity(product);
    await remoteDataSource.updateProduct(model);
    final allProducts = await remoteDataSource.fetchAllProducts();
    await localDataSource.cacheProducts(allProducts);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await remoteDataSource.deleteProduct(id);
    final updated = await remoteDataSource.fetchAllProducts();
    await localDataSource.cacheProducts(updated);
  }
}
