import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/product/data/datasources/product_local_datasource.dart';
import 'package:task_6/features/product/data/datasources/product_remote_datasource.dart';
import 'package:task_6/features/product/data/models/product_model.dart';
import 'package:task_6/features/product/domain/repositories/product_repo_impl.dart';
import 'package:task_6/features/product/domain/entities/product.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements ProductLocalDataSource {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    mockLocal = MockLocalDataSource();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  final testProduct = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 99.99,
  );

  test('should create a product using remote datasource', () async {
    // Arrange
    when(mockRemote.createProduct(testProduct)).thenAnswer((_) async {});
    when(mockRemote.fetchAllProducts()).thenAnswer((_) async => <ProductModel>[]);
    when(mockLocal.cacheProducts(any<ProductModel>)).thenAnswer((_) async {});

    // Act
    await repository.createProduct(testProduct);

    // Assert
    verify(mockRemote.createProduct(testProduct)).called(1);
    verify(mockRemote.fetchAllProducts()).called(1);
    verify(mockLocal.cacheProducts(any<ProductModel>)).called(1);
  });
}