class ValidationUtils {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Price validation
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    
    final price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid price';
    }
    
    if (price < 0) {
      return 'Price cannot be negative';
    }
    
    return null;
  }

  // Phone number validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  // URL validation
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    );
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  // Product name validation
  static String? validateProductName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Product name must be at least 2 characters long';
    }
    
    if (value.trim().length > 100) {
      return 'Product name cannot exceed 100 characters';
    }
    
    return null;
  }

  // Product description validation
  static String? validateProductDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product description is required';
    }
    
    if (value.trim().length < 10) {
      return 'Product description must be at least 10 characters long';
    }
    
    if (value.trim().length > 500) {
      return 'Product description cannot exceed 500 characters';
    }
    
    return null;
  }

  // Category validation
  static String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Category is required';
    }
    
    return null;
  }

  // Rating validation
  static String? validateRating(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rating is required';
    }
    
    final rating = double.tryParse(value);
    if (rating == null) {
      return 'Please enter a valid rating';
    }
    
    if (rating < 0 || rating > 5) {
      return 'Rating must be between 0 and 5';
    }
    
    return null;
  }

  // Generic number validation
  static String? validateNumber(String? value, String fieldName, {double? min, double? max}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid $fieldName';
    }
    
    if (min != null && number < min) {
      return '$fieldName cannot be less than $min';
    }
    
    if (max != null && number > max) {
      return '$fieldName cannot be greater than $max';
    }
    
    return null;
  }

  // Generic length validation
  static String? validateLength(String? value, String fieldName, {int? minLength, int? maxLength}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    final length = value.trim().length;
    
    if (minLength != null && length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }
    
    if (maxLength != null && length > maxLength) {
      return '$fieldName cannot exceed $maxLength characters';
    }
    
    return null;
  }
} 