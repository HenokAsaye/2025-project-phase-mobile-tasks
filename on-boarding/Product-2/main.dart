import 'dart:io';

class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);
  String get name => _name;
  String get description => _description;
  double get price => _price;
  set name(String value) => _name = value;
  set description(String value) => _description = value;
  set price(double value) => _price = value;
  @override
  String toString() {
    return 'Name: $_name\nDescription: $_description\nPrice: \$$_price';
  }
}

class ProductManager {
  final List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    print("Product added successfully!");
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print("No products available.");
    } else {
      for (int i = 0; i < _products.length; i++) {
        print('\Product ID: $i');
        print(_products[i]);
      }
    }
  }

  void viewProduct(int index) {
    if (index >= 0 && index < _products.length) {
      print(_products[index]);
    } else {
      print("Product not found.");
    }
  }

  void editProduct(int index, String name, String description, double price) {
    if (index >= 0 && index < _products.length) {
      _products[index]
        ..name = name
        ..description = description
        ..price = price;
      print("Product updated successfully!");
    } else {
      print("Invalid product ID.");
    }
  }

  void deleteProduct(int index) {
    if (index >= 0 && index < _products.length) {
      _products.removeAt(index);
      print("Product deleted successfully!");
    } else {
      print("Invalid product ID.");
    }
  }
}

void main() {
  final manager = ProductManager();

  while (true) {
    print('\n==== eCommerce CLI ====');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Product by ID');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');
    stdout.write('Enter your choice: ');
    final input = stdin.readLineSync();

    switch (input) {
      case '1':
        stdout.write('Enter product name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter product description: ');
        String description = stdin.readLineSync()!;
        stdout.write('Enter product price: ');
        double price = double.tryParse(stdin.readLineSync()!) ?? 0.0;
        manager.addProduct(Product(name, description, price));
        break;

      case '2':
        manager.viewAllProducts();
        break;

      case '3':
        stdout.write('Enter product ID: ');
        int id = int.tryParse(stdin.readLineSync()!) ?? -1;
        manager.viewProduct(id);
        break;

      case '4':
        stdout.write('Enter product ID to edit: ');
        int id = int.tryParse(stdin.readLineSync()!) ?? -1;
        stdout.write('Enter new name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter new description: ');
        String desc = stdin.readLineSync()!;
        stdout.write('Enter new price: ');
        double price = double.tryParse(stdin.readLineSync()!) ?? 0.0;
        manager.editProduct(id, name, desc, price);
        break;

      case '5':
        stdout.write('Enter product ID to delete: ');
        int id = int.tryParse(stdin.readLineSync()!) ?? -1;
        manager.deleteProduct(id);
        break;

      case '6':
        print('Exiting application...');
        return;

      default:
        print('Invalid choice. Try again.');
    }
  }
}
