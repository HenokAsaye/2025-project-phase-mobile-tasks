import 'package:get_it/get_it.dart';
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

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // Network dependencies
    getIt.registerLazySingleton<http.Client>(() => http.Client());
    
    getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance(),
    );
    
    getIt.registerLazySingleton<HttpClientService>(
      () => HttpClientService(client: getIt<http.Client>()),
    );
    
    getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
    );

    // Data sources
    getIt.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(httpClient: getIt<HttpClientService>()),
    );
    
    getIt.registerLazySingletonAsync<ProductLocalDataSource>(() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      return ProductLocalDataSourceImpl(sharedPreferences: sharedPreferences);
    });

    // Repositories
    getIt.registerLazySingletonAsync<ProductRepository>(() async {
      await getIt.isReady<ProductLocalDataSource>();
      return ProductRepositoryImpl(
        remoteDataSource: getIt<ProductRemoteDataSource>(),
        localDataSource: getIt<ProductLocalDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      );
    });

    // Use cases
    getIt.registerLazySingletonAsync<ViewAllProductsUseCase>(() async {
      await getIt.isReady<ProductRepository>();
      return ViewAllProductsUseCase(getIt<ProductRepository>());
    });
    
    getIt.registerLazySingletonAsync<ViewProductUseCase>(() async {
      await getIt.isReady<ProductRepository>();
      return ViewProductUseCase(getIt<ProductRepository>());
    });
    
    getIt.registerLazySingletonAsync<CreateProductUseCase>(() async {
      await getIt.isReady<ProductRepository>();
      return CreateProductUseCase(getIt<ProductRepository>());
    });
    
    getIt.registerLazySingletonAsync<UpdateProductUseCase>(() async {
      await getIt.isReady<ProductRepository>();
      return UpdateProductUseCase(getIt<ProductRepository>());
    });
    
    getIt.registerLazySingletonAsync<DeleteProductUseCase>(() async {
      await getIt.isReady<ProductRepository>();
      return DeleteProductUseCase(getIt<ProductRepository>());
    });

    // BLoC
    getIt.registerFactory<ProductBloc>(() {
      return ProductBloc(
        getAllProducts: getIt<ViewAllProductsUseCase>(),
        getSingleProduct: getIt<ViewProductUseCase>(),
        updateProduct: getIt<UpdateProductUseCase>(),
        deleteProduct: getIt<DeleteProductUseCase>(),
        createProduct: getIt<CreateProductUseCase>(),
      );
    });
  }

  static Future<void> reset() async {
    await getIt.reset();
  }

  static void dispose() {
    getIt<http.Client>().close();
  }
} 