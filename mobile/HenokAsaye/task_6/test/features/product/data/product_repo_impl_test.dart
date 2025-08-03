import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/product/data/datasources/product_local_datasource.dart';
import 'package:task_6/features/product/data/datasources/product_remote_datasource.dart';
import 'package:task_6/features/product/data/models/product_model.dart';
import 'package:task_6/core/network/network_info.dart';
import 'package:task_6/features/product/domain/repositories/product_repo_impl.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    mockLocal = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
      networkInfo: mockNetworkInfo,
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
    final productList = [testProduct];
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockRemote.createProduct(testProduct)).thenAnswer((_) async {});
    when(mockRemote.fetchAllProducts()).thenAnswer((_) async => productList);
    when(mockLocal.cacheProducts(productList)).thenAnswer((_) async {});

    // Act
    await repository.createProduct(testProduct);

    // Assert
    verify(mockRemote.createProduct(testProduct)).called(1);
    verify(mockRemote.fetchAllProducts()).called(1);
    verify(mockLocal.cacheProducts(productList)).called(1);
  });
}
