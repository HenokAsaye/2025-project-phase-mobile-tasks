import 'package:flutter_test/flutter_test.dart';
import 'package:task_6/features/product/domain/entities/product.dart';
import 'package:task_6/features/product/presentation/bloc/product_event.dart';

void main() {
  group('ProductEvent', () {
    group('LoadAllProductsEvent', () {
      test('should be a ProductEvent', () {
        const event = LoadAllProductsEvent();
        expect(event, isA<ProductEvent>());
      });

      test('should have empty props', () {
        const event = LoadAllProductsEvent();
        expect(event.props, isEmpty);
      });

      test('should be equal when same instance', () {
        const event1 = LoadAllProductsEvent();
        const event2 = LoadAllProductsEvent();
        expect(event1, equals(event2));
      });
    });

    group('GetSingleProductEvent', () {
      test('should be a ProductEvent', () {
        const event = GetSingleProductEvent(productId: 'test-id');
        expect(event, isA<ProductEvent>());
      });

      test('should have productId in props', () {
        const event = GetSingleProductEvent(productId: 'test-id');
        expect(event.props, contains('test-id'));
      });

      test('should be equal when same productId', () {
        const event1 = GetSingleProductEvent(productId: 'test-id');
        const event2 = GetSingleProductEvent(productId: 'test-id');
        expect(event1, equals(event2));
      });

      test('should not be equal when different productId', () {
        const event1 = GetSingleProductEvent(productId: 'test-id-1');
        const event2 = GetSingleProductEvent(productId: 'test-id-2');
        expect(event1, isNot(equals(event2)));
      });
    });

    group('UpdateProductEvent', () {
      test('should be a ProductEvent', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const event = UpdateProductEvent(product: product);
        expect(event, isA<ProductEvent>());
      });

      test('should have product in props', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const event = UpdateProductEvent(product: product);
        expect(event.props, contains(product));
      });

      test('should be equal when same product', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const event1 = UpdateProductEvent(product: product);
        const event2 = UpdateProductEvent(product: product);
        expect(event1, equals(event2));
      });
    });

    group('DeleteProductEvent', () {
      test('should be a ProductEvent', () {
        const event = DeleteProductEvent(productId: 'test-id');
        expect(event, isA<ProductEvent>());
      });

      test('should have productId in props', () {
        const event = DeleteProductEvent(productId: 'test-id');
        expect(event.props, contains('test-id'));
      });

      test('should be equal when same productId', () {
        const event1 = DeleteProductEvent(productId: 'test-id');
        const event2 = DeleteProductEvent(productId: 'test-id');
        expect(event1, equals(event2));
      });

      test('should not be equal when different productId', () {
        const event1 = DeleteProductEvent(productId: 'test-id-1');
        const event2 = DeleteProductEvent(productId: 'test-id-2');
        expect(event1, isNot(equals(event2)));
      });
    });

    group('CreateProductEvent', () {
      test('should be a ProductEvent', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const event = CreateProductEvent(product: product);
        expect(event, isA<ProductEvent>());
      });

      test('should have product in props', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const event = CreateProductEvent(product: product);
        expect(event.props, contains(product));
      });

      test('should be equal when same product', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const event1 = CreateProductEvent(product: product);
        const event2 = CreateProductEvent(product: product);
        expect(event1, equals(event2));
      });
    });
  });
} 