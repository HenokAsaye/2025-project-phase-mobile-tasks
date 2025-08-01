import 'package:flutter_test/flutter_test.dart';
import 'package:task_6/features/product/data/models/product_model.dart';

void main() {
  group('ProductModel', () {
    final productJson = {
      'id': '123',
      'name': 'Test Product',
      'description': 'A test product',
      'imageUrl': 'https://example.com/image.jpg',
      'price': 99.99,
    };

    final productModel = ProductModel.fromJson(productJson);

    test('fromJson should return a valid model', () {
      expect(productModel.id, '123');
      expect(productModel.name, 'Test Product');
      expect(productModel.price, 99.99);
    });

    test('toJson should return a valid map', () {
      final json = productModel.toJson();
      expect(json, productJson);
    });
  });
}
