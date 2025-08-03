import 'package:flutter/material.dart';
import 'package:task_6/core/widgets/product_card.dart';
import 'package:task_6/core/widgets/loading_widget.dart';
import 'package:task_6/core/widgets/error_widget.dart';
import 'package:task_6/core/widgets/empty_state_widget.dart';
import 'package:task_6/core/constants/app_constants.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> products = [
    {
      "name": "Derby Leather Shoes",
      "price": 120,
      "image": AppConstants.defaultProductImage,
      "category": "Men's shoe",
      "rating": 4.0,
    },
    {
      "name": "Derby Leather Shoes",
      "price": 120,
      "image": AppConstants.defaultProductImage,
      "category": "Men's shoe",
      "rating": 4.0,
    },
    {
      "name": "Derby Leather Shoes",
      "price": 120,
      "image": AppConstants.defaultProductImage,
      "category": "Men's shoe",
      "rating": 4.0,
    },
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppConstants.addProductRoute);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSectionTitle(),
              const SizedBox(height: 16),
              _buildProductList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "July 14, 2025",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 15),
                children: [
                  TextSpan(
                    text: "Hello, ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: "Yohannes",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Icon(Icons.notifications_none),
        )
      ],
    );
  }

  Widget _buildSectionTitle() {
    return const Text(
      "Available Products",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildProductList() {
    if (_isLoading) {
      return const Expanded(
        child: LoadingWidget(
          message: AppConstants.loadingProductsMessage,
        ),
      );
    }

    if (_error != null) {
      return Expanded(
        child: NetworkErrorWidget(
          onRetry: _loadProducts,
          customMessage: _error,
        ),
      );
    }

    if (widget.products.isEmpty) {
      return Expanded(
        child: EmptyStateWidget(
          title: 'No Products',
          message: AppConstants.noProductsMessage,
          icon: Icons.inventory_2_outlined,
          onAction: () => Navigator.pushNamed(context, AppConstants.addProductRoute),
          actionLabel: 'Add Product',
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) => ProductCard(
          product: widget.products[index],
          onTap: () => Navigator.pushNamed(
            context,
            AppConstants.detailRoute,
            arguments: widget.products[index],
          ),
        ),
      ),
    );
  }

  void _loadProducts() {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
