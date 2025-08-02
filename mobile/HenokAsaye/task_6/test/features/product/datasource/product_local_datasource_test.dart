import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_6/core/error/exceptions.dart';
import 'package:task_6/features/product/data/datasources/product_local_datasources_impl.dart';
import 'package:task_6/features/product/data/models/product_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductLocalDataSourceImpl datasource;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    datasource = ProductLocalDataSourceImpl(sharedPreferences: mockPrefs);
  });

  final tProducts = [ProductModel(id: "1", name: "Test", price: 100,description: "test",imageUrl: "")];
  final jsonString = jsonEncode(tProducts.map((e) => e.toJson()).toList());

test('should return cached products when there is cached data', () async {
  final cachedJson = jsonEncode(tProducts.map((e) => e.toJson()).toList());

  when(mockPrefs.getString(CACHED_PRODUCTS)).thenReturn(cachedJson);

  final result = await datasource.getCachedProducts();

  expect(result, tProducts);
});


  test('should throw CacheException when no cached data', () async {
    when(mockPrefs.getString(jsonString)).thenReturn(null);
    expect(() => datasource.getCachedProducts(), throwsA(isA<CacheException>()));
  });

test('should cache the products', () async {
  final expectedJsonString = jsonEncode(tProducts.map((e) => e.toJson()).toList());

  when(mockPrefs.setString(CACHED_PRODUCTS, expectedJsonString))
      .thenAnswer((_) async => true);

  await datasource.cacheProducts(tProducts);

  verify(mockPrefs.setString(CACHED_PRODUCTS, expectedJsonString));
});


}
