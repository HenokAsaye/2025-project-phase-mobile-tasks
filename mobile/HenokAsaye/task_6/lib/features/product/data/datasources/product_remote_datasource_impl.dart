import 'package:task_6/core/error/exceptions.dart';
import 'package:task_6/core/network/http_client_service.dart';
import 'package:task_6/core/utils/json_utils.dart';
import 'package:task_6/features/product/data/models/product_model.dart';
import 'product_remote_datasource.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final HttpClientService _httpClient;

  ProductRemoteDataSourceImpl({required HttpClientService httpClient})
      : _httpClient = httpClient;

  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final response = await _httpClient.get('');
      
      // Handle both list and object responses
      List<dynamic> jsonList;
      if (response.containsKey('data')) {
        jsonList = response['data'] as List<dynamic>;
      } else {
        jsonList = response.values.first as List<dynamic>;
      }
      
      return JsonUtils.decodeList(jsonList, ProductModel.fromJson);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> fetchProductById(String id) async {
    try {
      final response = await _httpClient.get(id);
      return JsonUtils.decodeModel(response, ProductModel.fromJson);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    try {
      final productJson = JsonUtils.encodeModel(product, (p) => p.toJson());
      await _httpClient.post('', body: productJson);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final productJson = JsonUtils.encodeModel(product, (p) => p.toJson());
      await _httpClient.put(product.id, body: productJson);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await _httpClient.delete(id);
    } catch (e) {
      throw ServerException();
    }
  }
}
