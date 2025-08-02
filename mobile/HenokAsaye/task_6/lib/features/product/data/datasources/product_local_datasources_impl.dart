import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_6/core/error/exceptions.dart';
import 'package:task_6/features/product/data/datasources/product_local_datasource.dart';
import 'package:task_6/features/product/data/models/product_model.dart';

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final jsonString = jsonEncode(
      products.map((p) => p.toJson()).toList(),
    );
    await sharedPreferences.setString(CACHED_PRODUCTS, jsonString);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCTS);
    if (jsonString != null) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      final List<ProductModel> products = decoded
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
      return Future.value(products);
    } else {
      throw CacheException();
    }
  }
}
