import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final product = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (product != null && !isEdit) {
      _nameController.text = product['name'];
      _categoryController.text = product['category'];
      _priceController.text = product['price'].toString();
      _descriptionController.text = product['description'] ?? '';
      isEdit = true;
    }
  }

  void _submitForm() {
    final newProduct = {
      'name': _nameController.text,
      'category': _categoryController.text,
      'price': int.tryParse(_priceController.text) ?? 0,
      'rating': 0.0,
      'image': 'assets/Img/shoe.jpg',
      'description': _descriptionController.text,
    };

    Navigator.pop(context, newProduct); // Pass data back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(isEdit ? "Edit Product" : "Add Product"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 40, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Upload image', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Name"),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Category"),
            const SizedBox(height: 6),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Price"),
            const SizedBox(height: 6),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    '\$',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Description"),
            const SizedBox(height: 6),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                ),
                onPressed: _submitForm,
                child: Text(
                  isEdit ? "UPDATE" : "ADD",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            if (isEdit) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                  ),
                  onPressed: () {
                    Navigator.pop(context, {'delete': true});
                  },
                  child: const Text("DELETE"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
