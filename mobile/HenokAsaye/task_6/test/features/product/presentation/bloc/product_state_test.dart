import 'package:flutter_test/flutter_test.dart';
import 'package:task_6/features/product/domain/entities/product.dart';
import 'package:task_6/features/product/presentation/bloc/product_state.dart';

void main() {
  group('ProductState', () {
    group('InitialState', () {
      test('should be a ProductState', () {
        const state = InitialState();
        expect(state, isA<ProductState>());
      });

      test('should have empty props', () {
        const state = InitialState();
        expect(state.props, isEmpty);
      });

      test('should be equal when same instance', () {
        const state1 = InitialState();
        const state2 = InitialState();
        expect(state1, equals(state2));
      });
    });

    group('LoadingState', () {
      test('should be a ProductState', () {
        const state = LoadingState();
        expect(state, isA<ProductState>());
      });

      test('should have empty props', () {
        const state = LoadingState();
        expect(state.props, isEmpty);
      });

      test('should be equal when same instance', () {
        const state1 = LoadingState();
        const state2 = LoadingState();
        expect(state1, equals(state2));
      });
    });

    group('LoadedAllProductsState', () {
      test('should be a ProductState', () {
        const products = [
          Product(
            id: 'test-id-1',
            name: 'Test Product 1',
            description: 'Test Description 1',
            imageUrl: 'test-image-1.jpg',
            price: 100.0,
          ),
          Product(
            id: 'test-id-2',
            name: 'Test Product 2',
            description: 'Test Description 2',
            imageUrl: 'test-image-2.jpg',
            price: 200.0,
          ),
        ];
        const state = LoadedAllProductsState(products: products);
        expect(state, isA<ProductState>());
      });

      test('should have products in props', () {
        const products = [
          Product(
            id: 'test-id-1',
            name: 'Test Product 1',
            description: 'Test Description 1',
            imageUrl: 'test-image-1.jpg',
            price: 100.0,
          ),
        ];
        const state = LoadedAllProductsState(products: products);
        expect(state.props, contains(products));
      });

      test('should be equal when same products', () {
        const products = [
          Product(
            id: 'test-id-1',
            name: 'Test Product 1',
            description: 'Test Description 1',
            imageUrl: 'test-image-1.jpg',
            price: 100.0,
          ),
        ];
        const state1 = LoadedAllProductsState(products: products);
        const state2 = LoadedAllProductsState(products: products);
        expect(state1, equals(state2));
      });

      test('should not be equal when different products', () {
        const products1 = [
          Product(
            id: 'test-id-1',
            name: 'Test Product 1',
            description: 'Test Description 1',
            imageUrl: 'test-image-1.jpg',
            price: 100.0,
          ),
        ];
        const products2 = [
          Product(
            id: 'test-id-2',
            name: 'Test Product 2',
            description: 'Test Description 2',
            imageUrl: 'test-image-2.jpg',
            price: 200.0,
          ),
        ];
        const state1 = LoadedAllProductsState(products: products1);
        const state2 = LoadedAllProductsState(products: products2);
        expect(state1, isNot(equals(state2)));
      });
    });

    group('LoadedSingleProductState', () {
      test('should be a ProductState', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const state = LoadedSingleProductState(product: product);
        expect(state, isA<ProductState>());
      });

      test('should have product in props', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const state = LoadedSingleProductState(product: product);
        expect(state.props, contains(product));
      });

      test('should be equal when same product', () {
        const product = Product(
          id: 'test-id',
          name: 'Test Product',
          description: 'Test Description',
          imageUrl: 'test-image.jpg',
          price: 100.0,
        );
        const state1 = LoadedSingleProductState(product: product);
        const state2 = LoadedSingleProductState(product: product);
        expect(state1, equals(state2));
      });

      test('should not be equal when different product', () {
        const product1 = Product(
          id: 'test-id-1',
          name: 'Test Product 1',
          description: 'Test Description 1',
          imageUrl: 'test-image-1.jpg',
          price: 100.0,
        );
        const product2 = Product(
          id: 'test-id-2',
          name: 'Test Product 2',
          description: 'Test Description 2',
          imageUrl: 'test-image-2.jpg',
          price: 200.0,
        );
        const state1 = LoadedSingleProductState(product: product1);
        const state2 = LoadedSingleProductState(product: product2);
        expect(state1, isNot(equals(state2)));
      });
    });

    group('ErrorState', () {
      test('should be a ProductState', () {
        const state = ErrorState(message: 'Test error message');
        expect(state, isA<ProductState>());
      });

      test('should have message in props', () {
        const state = ErrorState(message: 'Test error message');
        expect(state.props, contains('Test error message'));
      });

      test('should be equal when same message', () {
        const state1 = ErrorState(message: 'Test error message');
        const state2 = ErrorState(message: 'Test error message');
        expect(state1, equals(state2));
      });

      test('should not be equal when different message', () {
        const state1 = ErrorState(message: 'Test error message 1');
        const state2 = ErrorState(message: 'Test error message 2');
        expect(state1, isNot(equals(state2)));
      });
    });
  });
} 