import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_6/core/widgets/custom_text_field.dart';
import 'package:task_6/core/widgets/custom_button.dart';
import 'package:task_6/core/widgets/loading_widget.dart';
import 'package:task_6/core/utils/validation_utils.dart';
import 'package:task_6/core/constants/app_constants.dart';
import 'package:task_6/features/product/domain/entities/product.dart';
import 'package:task_6/features/product/presentation/bloc/product_bloc.dart';
import 'package:task_6/features/product/presentation/bloc/product_event.dart';
import 'package:task_6/features/product/presentation/bloc/product_state.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
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
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoadedAllProductsState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isUpdating 
                      ? AppConstants.productUpdatedMessage 
                      : AppConstants.productAddedMessage,
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state is LoadingState
                ? const LoadingWidget(message: AppConstants.savingProductMessage)
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildImageUploadSection(),
                          const SizedBox(height: 24),
                          _buildFormFields(),
                          const SizedBox(height: 32),
                          _buildSubmitButton(isUpdating),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: Colors.grey.shade400, width: 2, style: BorderStyle.solid),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.image, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'Upload image',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        CustomTextField(
          label: "Name",
          controller: _nameController,
          validator: ValidationUtils.validateProductName,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: "Category",
          controller: _categoryController,
          validator: ValidationUtils.validateCategory,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: "Price",
          controller: _priceController,
          keyboardType: TextInputType.number,
          validator: ValidationUtils.validatePrice,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: "Description",
          controller: _descriptionController,
          maxLines: 3,
          validator: ValidationUtils.validateProductDescription,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(bool isUpdating) {
    return CustomButton(
      text: isUpdating ? "Update Product" : "Add Product",
      onPressed: _handleSubmit,
      icon: isUpdating ? Icons.update : Icons.add,
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        imageUrl: AppConstants.defaultProductImage,
        price: double.parse(_priceController.text),
      );

      if (widget.product != null) {
        context.read<ProductBloc>().add(UpdateProductEvent(product: product));
      } else {
        context.read<ProductBloc>().add(CreateProductEvent(product: product));
      }
    }
  }
}
