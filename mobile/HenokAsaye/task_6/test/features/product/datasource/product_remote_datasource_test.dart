import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/product/data/models/product_model.dart';
import 'package:task_6/features/product/data/datasources/product_remote_datasource_impl.dart';
import 'package:task_6/core/error/exceptions.dart';
import 'package:task_6/core/network/http_client_service.dart';

import 'product_remote_datasource_test.mocks.dart';

@GenerateMocks([HttpClientService])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClientService mockHttpClientService;

  setUp(() {
    mockHttpClientService = MockHttpClientService();
    dataSource = ProductRemoteDataSourceImpl(httpClient: mockHttpClientService);
  });

  final tProducts = [
    ProductModel(
      id: '1',
      name: 'Shirt',
      description: 'Cotton shirt',
      imageUrl: 'https://dummyimg.com/shirt',
      price: 25.0,
    ),
  ];

  final jsonResponse = {
    'data': tProducts.map((e) => e.toJson()).toList(),
  };

  group('fetchAllProducts', () {
    test('should return List<ProductModel> when the response is successful', () async {
      // arrange
      when(mockHttpClientService.get(''))
          .thenAnswer((_) async => jsonResponse);

      // act
      final result = await dataSource.fetchAllProducts();

      // assert
      expect(result, equals(tProducts));
      verify(mockHttpClientService.get('')).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });

    test('should throw ServerException when the response fails', () async {
      // arrange
      when(mockHttpClientService.get(''))
          .thenThrow(ServerException());

      // act
      final call = dataSource.fetchAllProducts;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
      verify(mockHttpClientService.get('')).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });
  });

  group('fetchProductById', () {
    test('should return ProductModel when the response is successful', () async {
      // arrange
      final productJson = tProducts.first.toJson();
      when(mockHttpClientService.get('1'))
          .thenAnswer((_) async => productJson);

      // act
      final result = await dataSource.fetchProductById('1');

      // assert
      expect(result, equals(tProducts.first));
      verify(mockHttpClientService.get('1')).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });

    test('should throw ServerException when the response fails', () async {
      // arrange
      when(mockHttpClientService.get('1'))
          .thenThrow(ServerException());

      // act
      final call = dataSource.fetchProductById;

      // assert
      expect(() => call('1'), throwsA(isA<ServerException>()));
      verify(mockHttpClientService.get('1')).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });
  });

  group('createProduct', () {
    test('should not throw when the response is successful', () async {
      // arrange
      when(mockHttpClientService.post('', body: anyNamed('body')))
          .thenAnswer((_) async => {});

      // act
      await dataSource.createProduct(tProducts.first);

      // assert
      verify(mockHttpClientService.post('', body: anyNamed('body'))).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });

    test('should throw ServerException when the response fails', () async {
      // arrange
      when(mockHttpClientService.post('', body: anyNamed('body')))
          .thenThrow(ServerException());

      // act
      final call = dataSource.createProduct;

      // assert
      expect(() => call(tProducts.first), throwsA(isA<ServerException>()));
      verify(mockHttpClientService.post('', body: anyNamed('body'))).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });
  });

  group('updateProduct', () {
    test('should not throw when the response is successful', () async {
      // arrange
      when(mockHttpClientService.put('1', body: anyNamed('body')))
          .thenAnswer((_) async => {});

      // act
      await dataSource.updateProduct(tProducts.first);

      // assert
      verify(mockHttpClientService.put('1', body: anyNamed('body'))).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });

    test('should throw ServerException when the response fails', () async {
      // arrange
      when(mockHttpClientService.put('1', body: anyNamed('body')))
          .thenThrow(ServerException());

      // act
      final call = dataSource.updateProduct;

      // assert
      expect(() => call(tProducts.first), throwsA(isA<ServerException>()));
      verify(mockHttpClientService.put('1', body: anyNamed('body'))).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });
  });

  group('deleteProduct', () {
    test('should not throw when the response is successful', () async {
      // arrange
      when(mockHttpClientService.delete('1'))
          .thenAnswer((_) async => {});

      // act
      await dataSource.deleteProduct('1');

      // assert
      verify(mockHttpClientService.delete('1')).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });

    test('should throw ServerException when the response fails', () async {
      // arrange
      when(mockHttpClientService.delete('1'))
          .thenThrow(ServerException());

      // act
      final call = dataSource.deleteProduct;

      // assert
      expect(() => call('1'), throwsA(isA<ServerException>()));
      verify(mockHttpClientService.delete('1')).called(1);
      verifyNoMoreInteractions(mockHttpClientService);
    });
  });
}
