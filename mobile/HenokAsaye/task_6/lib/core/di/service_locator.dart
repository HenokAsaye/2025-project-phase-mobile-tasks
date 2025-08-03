import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/http_client_service.dart';
import '../network/network_info.dart';
import '../../features/product/data/datasources/product_remote_datasource.dart';
import '../../features/product/data/datasources/product_remote_datasource_impl.dart';
import '../../features/product/data/datasources/product_local_datasource.dart';
import '../../features/product/data/datasources/product_local_datasources_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/repositories/product_repo_impl.dart';
import '../../features/product/domain/usecases/create_product_usecase.dart';
import '../../features/product/domain/usecases/delete_product_usecase.dart';
import '../../features/product/domain/usecases/update_product_usecase.dart';
import '../../features/product/domain/usecases/view_All_products_usecase.dart';
import '../../features/product/domain/usecases/view_product_usecase.dart';
import '../../features/product/presentation/bloc/product_bloc.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Network dependencies
  http.Client get httpClient => http.Client();
  
  InternetConnectionChecker get internetConnectionChecker => InternetConnectionChecker.createInstance();
  
  HttpClientService get httpClientService => HttpClientService(
    client: httpClient,
  );
  
  NetworkInfo get networkInfo => NetworkInfoImpl(internetConnectionChecker);

  // Data sources
  ProductRemoteDataSource get productRemoteDataSource => ProductRemoteDataSourceImpl(
    httpClient: httpClientService,
  );
  
  Future<ProductLocalDataSource> get productLocalDataSource async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return ProductLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  }

  // Repositories
  Future<ProductRepository> get productRepository async {
    final localDataSource = await productLocalDataSource;
    return ProductRepositoryImpl(
      remoteDataSource: productRemoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
  }

  // Use cases
  Future<ViewAllProductsUseCase> get viewAllProductsUseCase async {
    final repository = await productRepository;
    return ViewAllProductsUseCase(repository);
  }
  
  Future<ViewProductUseCase> get viewProductUseCase async {
    final repository = await productRepository;
    return ViewProductUseCase(repository);
  }
  
  Future<CreateProductUseCase> get createProductUseCase async {
    final repository = await productRepository;
    return CreateProductUseCase(repository);
  }
  
  Future<UpdateProductUseCase> get updateProductUseCase async {
    final repository = await productRepository;
    return UpdateProductUseCase(repository);
  }
  
  Future<DeleteProductUseCase> get deleteProductUseCase async {
    final repository = await productRepository;
    return DeleteProductUseCase(repository);
  }

  // BLoC
  Future<ProductBloc> get productBloc async {
    return ProductBloc(
      getAllProducts: await viewAllProductsUseCase,
      getSingleProduct: await viewProductUseCase,
      updateProduct: await updateProductUseCase,
      deleteProduct: await deleteProductUseCase,
      createProduct: await createProductUseCase,
    );
  }

  void dispose() {
    httpClient.close();
  }
} 