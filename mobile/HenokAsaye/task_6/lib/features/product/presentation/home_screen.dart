import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_6/core/widgets/product_card.dart';
import 'package:task_6/core/widgets/loading_widget.dart';
import 'package:task_6/core/widgets/error_widget.dart';
import 'package:task_6/core/constants/app_constants.dart';
import 'package:task_6/features/product/presentation/bloc/product_bloc.dart';
import 'package:task_6/features/product/presentation/bloc/product_event.dart';
import 'package:task_6/features/product/presentation/bloc/product_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const LoadAllProductsEvent());
  }

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
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Expanded(
            child: LoadingWidget(
              message: AppConstants.loadingProductsMessage,
            ),
          );
        }

        if (state is ErrorState) {
          return Expanded(
            child: NetworkErrorWidget(
              onRetry: () {
                context.read<ProductBloc>().add(const LoadAllProductsEvent());
              },
              customMessage: state.message,
            ),
          );
        }

        if (state is LoadedAllProductsState) {
          if (state.products.isEmpty) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.noProductsMessage,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, AppConstants.addProductRoute),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Product'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Expanded(
            child: ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                final productData = {
                  'id': product.id,
                  'name': product.name,
                  'price': product.price,
                  'image': AppConstants.defaultProductImage,
                  'category': 'Category',
                  'rating': 4.0,
                  'description': product.description,
                };

                return ProductCard(
                  product: productData,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppConstants.detailRoute,
                    arguments: productData,
                  ),
                );
              },
            ),
          );
        }
        return const Expanded(
          child: LoadingWidget(
            message: AppConstants.loadingProductsMessage,
          ),
        );
      },
    );
  }
}
