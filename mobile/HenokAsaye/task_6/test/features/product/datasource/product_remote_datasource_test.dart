import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:task_6/features/product/data/models/product_model.dart';
import 'package:task_6/features/product/data/datasources/product_remote_datasource_impl.dart';
import 'package:task_6/core/error/exceptions.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
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

  final jsonResponse = jsonEncode(tProducts.map((e) => e.toJson()).toList());

  final dummyUri = Uri.parse('https://dummyapi.com/products');

  group('fetchAllProducts', () {
    test('should return List<ProductModel> when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(dummyUri, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      // act
      final result = await dataSource.fetchAllProducts();

      // assert
      expect(result, equals(tProducts));
      verify(mockHttpClient.get(dummyUri, headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(dummyUri, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      // act
      final call = dataSource.fetchAllProducts;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
      verify(mockHttpClient.get(dummyUri, headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });
  });
}
