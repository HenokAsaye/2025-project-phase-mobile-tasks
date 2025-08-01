import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  final Map<String, dynamic>? product; // Accept product argument for editing

  const AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?['name'] ?? '');
    _categoryController = TextEditingController(text: widget.product?['category'] ?? '');
    _priceController = TextEditingController(
      text: widget.product?['price']?.toString() ?? '',
    );
    _descriptionController = TextEditingController(text: widget.product?['description'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdating = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(isUpdating ? "Update Product" : "Add Product"),
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image, size: 40, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'upload image',
                      style: TextStyle(color: Colors.grey),
                    ),
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
                fillColor: Colors.grey[200],
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: () {
                  final productData = {
                    'name': _nameController.text,
                    'category': _categoryController.text,
                    'price': double.tryParse(_priceController.text) ?? 0.0,
                    'description': _descriptionController.text,
                  };
                  Navigator.pop(context, productData); // Pass back the data
                },
                child: Text(
                  isUpdating ? "UPDATE" : "ADD",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (isUpdating) // Only show DELETE in edit mode
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: () {
                    // Return something like {'delete': true} if needed
                    Navigator.pop(context, {'delete': true});
                  },
                  child: const Text("DELETE"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
