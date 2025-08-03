# Task 18: Dependency Injection Implementation

This document describes the implementation of dependency injection using the `get_it` package in the Flutter project.

## Overview

The project now uses the `get_it` package for dependency injection, which provides a clean and efficient way to manage dependencies throughout the application. This implementation follows clean architecture principles and promotes better testability, maintainability, and organization.

## Setup and Configuration

### 1. Package Addition
The `get_it` package has been added to `pubspec.yaml`:
```yaml
dependencies:
  get_it: ^7.6.7
```

### 2. Service Locator Implementation
The dependency injection container is implemented in `lib/core/di/service_locator.dart` with the following features:

- **Singleton Instance**: Uses `GetIt.instance` as the global service locator
- **Proper Scoping**: Different registration methods for different lifecycle needs
- **Dependency Chain Management**: Ensures dependencies are resolved in the correct order

## Dependency Registration

### Network Dependencies
```dart
// HTTP Client - Singleton
getIt.registerLazySingleton<http.Client>(() => http.Client());

// Internet Connection Checker - Singleton
getIt.registerLazySingleton<InternetConnectionChecker>(
  () => InternetConnectionChecker.createInstance(),
);

// HTTP Client Service - Singleton
getIt.registerLazySingleton<HttpClientService>(
  () => HttpClientService(client: getIt<http.Client>()),
);

// Network Info - Singleton
getIt.registerLazySingleton<NetworkInfo>(
  () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
);
```

### Data Sources
```dart
// Remote Data Source - Singleton
getIt.registerLazySingleton<ProductRemoteDataSource>(
  () => ProductRemoteDataSourceImpl(httpClient: getIt<HttpClientService>()),
);

// Local Data Source - Async Singleton
getIt.registerLazySingletonAsync<ProductLocalDataSource>(() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return ProductLocalDataSourceImpl(sharedPreferences: sharedPreferences);
});
```

### Repositories
```dart
// Product Repository - Async Singleton with dependency waiting
getIt.registerLazySingletonAsync<ProductRepository>(() async {
  await getIt.isReady<ProductLocalDataSource>();
  return ProductRepositoryImpl(
    remoteDataSource: getIt<ProductRemoteDataSource>(),
    localDataSource: getIt<ProductLocalDataSource>(),
    networkInfo: getIt<NetworkInfo>(),
  );
});
```

### Use Cases
All use cases are registered as async singletons with proper dependency waiting:
```dart
getIt.registerLazySingletonAsync<ViewAllProductsUseCase>(() async {
  await getIt.isReady<ProductRepository>();
  return ViewAllProductsUseCase(getIt<ProductRepository>());
});
```

### BLoC
The ProductBloc is registered as a factory to ensure a fresh instance for each widget:
```dart
getIt.registerFactory<ProductBloc>(() {
  return ProductBloc(
    getAllProducts: getIt<ViewAllProductsUseCase>(),
    getSingleProduct: getIt<ViewProductUseCase>(),
    updateProduct: getIt<UpdateProductUseCase>(),
    deleteProduct: getIt<DeleteProductUseCase>(),
    createProduct: getIt<CreateProductUseCase>(),
  );
});
```

## Initialization

The dependency injection container is initialized in `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  runApp(const MyApp());
}
```

## Usage in Application

### Accessing Dependencies
Dependencies can be accessed anywhere in the application using:
```dart
final bloc = getIt<ProductBloc>();
final repository = getIt<ProductRepository>();
```

### In Widgets
The ProductBloc is provided to the widget tree using:
```dart
BlocProvider(
  create: (context) => getIt<ProductBloc>(),
  child: MaterialApp(...),
)
```

## Benefits of This Implementation

### 1. Clean Architecture Compliance
- Dependencies are injected through constructors
- Clear separation of concerns
- Easy to swap implementations

### 2. Testability
- Dependencies can be easily mocked for testing
- Isolated unit testing is possible
- Clear dependency graph

### 3. Maintainability
- Centralized dependency management
- Easy to modify dependencies
- Clear dependency relationships

### 4. Performance
- Lazy loading of dependencies
- Singleton pattern for expensive objects
- Factory pattern for stateful objects

## Registration Scopes

### Singleton (`registerLazySingleton`)
- Used for stateless services that can be shared
- Created once and reused throughout the app
- Examples: HTTP client, network info, repositories

### Async Singleton (`registerLazySingletonAsync`)
- Used for dependencies that require async initialization
- Examples: Local data sources that need SharedPreferences

### Factory (`registerFactory`)
- Used for stateful objects that need fresh instances
- Examples: BLoCs that maintain state

## Error Handling

The implementation includes proper error handling:
- `getIt.isReady<T>()` ensures dependencies are fully initialized
- Async registration handles initialization order
- Proper disposal of resources

## Testing Support

The dependency injection setup supports testing by:
- Allowing easy mocking of dependencies
- Providing clear dependency injection points
- Supporting dependency replacement for tests

## Conclusion

This dependency injection implementation provides a robust foundation for the application's architecture. It follows clean architecture principles, promotes testability, and ensures proper resource management. The use of `get_it` package makes the implementation efficient and easy to maintain. 