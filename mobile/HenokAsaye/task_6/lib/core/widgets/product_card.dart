import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;
  final double? imageHeight;
  final double? borderRadius;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.showActions = false,
    this.imageHeight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with actions overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(borderRadius ?? 20),
                  ),
                  child: Image.asset(
                    product['image'] ?? 'assets/Img/shoe.jpg',
                    width: double.infinity,
                    height: imageHeight ?? 180,
                    fit: BoxFit.cover,
                  ),
                ),
                if (showActions)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (onEdit != null)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: onEdit,
                              icon: const Icon(Icons.edit, size: 18),
                              iconSize: 18,
                              padding: const EdgeInsets.all(4),
                            ),
                          ),
                        if (onEdit != null && onDelete != null)
                          const SizedBox(width: 4),
                        if (onDelete != null)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: onDelete,
                              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                              iconSize: 18,
                              padding: const EdgeInsets.all(4),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            
            // Product info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Price
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product['name'] ?? 'Product Name',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "\$${product['price']?.toString() ?? '0'}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Category & Rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product['category'] ?? 'Category',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            "(${product['rating']?.toString() ?? '0.0'})",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  // Description (if available)
                  if (product['description'] != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      product['description'],
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 