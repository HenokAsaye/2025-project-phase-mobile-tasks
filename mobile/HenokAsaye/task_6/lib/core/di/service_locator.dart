import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../network/http_client_service.dart';
import '../network/network_info.dart';
import '../../features/product/data/datasources/product_remote_datasource.dart';
import '../../features/product/data/datasources/product_remote_datasource_impl.dart';
import '../../features/product/data/datasources/product_local_datasource.dart';
import '../../features/product/data/datasources/product_local_datasources_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/repositories/product_repo_impl.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Network dependencies
  http.Client get httpClient => http.Client();
  
  InternetConnectionChecker get internetConnectionChecker => InternetConnectionChecker();
  
  HttpClientService get httpClientService => HttpClientService(
    client: httpClient,
  );
  
  NetworkInfo get networkInfo => NetworkInfoImpl(internetConnectionChecker);

  // Data sources
  ProductRemoteDataSource get productRemoteDataSource => ProductRemoteDataSourceImpl(
    httpClient: httpClientService,
  );
  
  ProductLocalDataSource get productLocalDataSource => ProductLocalDataSourceImpl();

  // Repositories
  ProductRepository get productRepository => ProductRepositoryImpl(
    remoteDataSource: productRemoteDataSource,
    localDataSource: productLocalDataSource,
    networkInfo: networkInfo,
  );

  // Use cases
  // Note: Use cases will be created as needed in the presentation layer
  // This keeps the service locator focused on core dependencies

  void dispose() {
    httpClient.close();
  }
} 