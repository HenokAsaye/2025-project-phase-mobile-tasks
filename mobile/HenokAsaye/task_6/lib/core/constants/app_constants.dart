class AppConstants {
  static const String appName = 'Ecommerce App';
  static const String appVersion = '1.0.0';
  static const String baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/';
  static const int connectionTimeout = 30000; 
  static const int receiveTimeout = 30000; 
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultElevation = 2.0;
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  static const String requiredFieldMessage = 'This field is required';
  static const String invalidEmailMessage = 'Please enter a valid email';
  static const String invalidPriceMessage = 'Please enter a valid price';
  static const String invalidPhoneMessage = 'Please enter a valid phone number';
  static const String networkErrorMessage = 'Network error occurred. Please check your connection.';
  static const String serverErrorMessage = 'Server error occurred. Please try again later.';
  static const String unknownErrorMessage = 'An unknown error occurred.';
  static const String productAddedMessage = 'Product added successfully!';
  static const String productUpdatedMessage = 'Product updated successfully!';
  static const String productDeletedMessage = 'Product deleted successfully!';
  static const String loadingProductsMessage = 'Loading products...';
  static const String savingProductMessage = 'Saving product...';
  static const String deletingProductMessage = 'Deleting product...';
  static const String noProductsMessage = 'No products available at the moment.';
  static const String noSearchResultsMessage = 'No products found matching your search.';
  static const String homeRoute = '/';
  static const String searchRoute = '/search';
  static const String detailRoute = '/detail';
  static const String addProductRoute = '/add';
  static const String defaultProductImage = 'assets/Img/shoe.jpg';
  static const List<String> productCategories = [
    "Men's shoe",
    "Women's shoe",
    "Kids' shoe",
    "Sports shoe",
    "Casual shoe",
    "Formal shoe",
  ];
  static const Map<String, dynamic> defaultProduct = {
    "name": "Product Name",
    "price": 0.0,
    "image": defaultProductImage,
    "category": "Category",
    "rating": 0.0,
    "description": "Product description",
  };
} 