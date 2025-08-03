import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_6/features/product/domain/usecases/create_product_usecase.dart';
import 'package:task_6/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:task_6/features/product/domain/usecases/update_product_usecase.dart';
import 'package:task_6/features/product/domain/usecases/view_All_products_usecase.dart';
import 'package:task_6/features/product/domain/usecases/view_product_usecase.dart';
import 'package:task_6/features/product/presentation/bloc/product_event.dart';
import 'package:task_6/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUseCase getAllProducts;
  final ViewProductUseCase getSingleProduct;
  final UpdateProductUseCase updateProduct;
  final DeleteProductUseCase deleteProduct;
  final CreateProductUseCase createProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.getSingleProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.createProduct,
  }) : super(const InitialState()) {
    on<LoadAllProductsEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<CreateProductEvent>(_onCreateProduct);
  }

  Future<void> _onLoadAllProducts(
    LoadAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const LoadingState());
    
    try {
      final result = await getAllProducts();
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (products) => emit(LoadedAllProductsState(products: products)),
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetSingleProduct(
    GetSingleProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const LoadingState());
    
    try {
      final result = await getSingleProduct(event.productId);
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (product) => emit(LoadedSingleProductState(product: product)),
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const LoadingState());
    
    try {
      final result = await updateProduct(event.product);
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (_) => emit(const LoadedAllProductsState(products: [])),
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const LoadingState());
    
    try {
      final result = await deleteProduct(event.productId);
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (_) => emit(const LoadedAllProductsState(products: [])),
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const LoadingState());
    
    try {
      final result = await createProduct(event.product);
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (_) => emit(const LoadedAllProductsState(products: [])),
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
} 