import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_6/core/error/failures.dart';
import 'package:task_6/features/product/domain/entities/product.dart';
import 'package:task_6/features/product/domain/usecases/create_product_usecase.dart';
import 'package:task_6/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:task_6/features/product/domain/usecases/update_product_usecase.dart';
import 'package:task_6/features/product/domain/usecases/view_All_products_usecase.dart';
import 'package:task_6/features/product/domain/usecases/view_product_usecase.dart';
import 'package:task_6/features/product/presentation/bloc/product_bloc.dart';
import 'package:task_6/features/product/presentation/bloc/product_event.dart';
import 'package:task_6/features/product/presentation/bloc/product_state.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([
  ViewAllProductsUseCase,
  ViewProductUseCase,
  CreateProductUseCase,
  UpdateProductUseCase,
  DeleteProductUseCase,
])
void main() {
  late ProductBloc bloc;
  late MockViewAllProductsUseCase mockGetAllProducts;
  late MockViewProductUseCase mockGetSingleProduct;
  late MockCreateProductUseCase mockCreateProduct;
  late MockUpdateProductUseCase mockUpdateProduct;
  late MockDeleteProductUseCase mockDeleteProduct;

  setUp(() {
    mockGetAllProducts = MockViewAllProductsUseCase();
    mockGetSingleProduct = MockViewProductUseCase();
    mockCreateProduct = MockCreateProductUseCase();
    mockUpdateProduct = MockUpdateProductUseCase();
    mockDeleteProduct = MockDeleteProductUseCase();

    bloc = ProductBloc(
      getAllProducts: mockGetAllProducts,
      getSingleProduct: mockGetSingleProduct,
      createProduct: mockCreateProduct,
      updateProduct: mockUpdateProduct,
      deleteProduct: mockDeleteProduct,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be InitialState', () {
    expect(bloc.state, equals(const InitialState()));
  });

  group('LoadAllProductsEvent', () {
    final tProducts = [
      const Product(
        id: '1',
        name: 'Test Product 1',
        description: 'Test Description 1',
        imageUrl: 'test-image-1.jpg',
        price: 100.0,
      ),
      const Product(
        id: '2',
        name: 'Test Product 2',
        description: 'Test Description 2',
        imageUrl: 'test-image-2.jpg',
        price: 200.0,
      ),
    ];

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductsState] when successful',
      build: () {
        when(mockGetAllProducts()).thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        const LoadingState(),
        LoadedAllProductsState(products: tProducts),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when failure',
      build: () {
        when(mockGetAllProducts()).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        const LoadingState(),
        const ErrorState(message: 'ServerFailure()'),
      ],
    );
  });

  group('GetSingleProductEvent', () {
    const tProduct = Product(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      imageUrl: 'test-image.jpg',
      price: 100.0,
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedSingleProductState] when successful',
      build: () {
        when(mockGetSingleProduct('1')).thenAnswer((_) async => Right(tProduct));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(productId: '1')),
      expect: () => [
        const LoadingState(),
        LoadedSingleProductState(product: tProduct),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when failure',
      build: () {
        when(mockGetSingleProduct('1')).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(productId: '1')),
      expect: () => [
        const LoadingState(),
        const ErrorState(message: 'ServerFailure()'),
      ],
    );
  });

  group('CreateProductEvent', () {
    const tProduct = Product(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      imageUrl: 'test-image.jpg',
      price: 100.0,
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductsState] when successful',
      build: () {
        when(mockCreateProduct(tProduct)).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(product: tProduct)),
      expect: () => [
        const LoadingState(),
        const LoadedAllProductsState(products: []),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when failure',
      build: () {
        when(mockCreateProduct(tProduct)).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(product: tProduct)),
      expect: () => [
        const LoadingState(),
        const ErrorState(message: 'ServerFailure()'),
      ],
    );
  });

  group('UpdateProductEvent', () {
    const tProduct = Product(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      imageUrl: 'test-image.jpg',
      price: 100.0,
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductsState] when successful',
      build: () {
        when(mockUpdateProduct(tProduct)).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(product: tProduct)),
      expect: () => [
        const LoadingState(),
        const LoadedAllProductsState(products: []),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when failure',
      build: () {
        when(mockUpdateProduct(tProduct)).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(product: tProduct)),
      expect: () => [
        const LoadingState(),
        const ErrorState(message: 'ServerFailure()'),
      ],
    );
  });

  group('DeleteProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductsState] when successful',
      build: () {
        when(mockDeleteProduct('1')).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(productId: '1')),
      expect: () => [
        const LoadingState(),
        const LoadedAllProductsState(products: []),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when failure',
      build: () {
        when(mockDeleteProduct('1')).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(productId: '1')),
      expect: () => [
        const LoadingState(),
        const ErrorState(message: 'ServerFailure()'),
      ],
    );
  });
} 