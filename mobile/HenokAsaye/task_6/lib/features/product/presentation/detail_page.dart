import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              const SizedBox(height: 16),
              const ProductImage(),
              const SizedBox(height: 16),
              ProductInfo(product: product),
              const SizedBox(height: 16),
              const SizeRange(),
              const SizedBox(height: 16),
              const ProductDescription(),
              const SizedBox(height: 24),
              ActionButtons(product:product),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      )
    ]);
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({super.key});
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Image.asset('assets/Img/shoe.jpg'),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Text(
            product['title'] ?? 'No Title',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            product['price'] != null ? '\$${product['price']}' : '\$0',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey[500],
            ),
          ),
        ]),
        Row(children: [
          Text(
            product['category'] ?? "men's shoe",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey[500],
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 16),
              Text('(4.0)',
                  style: TextStyle(fontSize: 13, color: Colors.grey)),
            ],
          )
        ]),
      ],
    );
  }
}

class SizeRange extends StatefulWidget {
  const SizeRange({super.key});

  @override
  State<SizeRange> createState() => _SizeRangeState();
}

class _SizeRangeState extends State<SizeRange> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    final sizes = ['39', '40', '41', '42', '43', '44'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Size'),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: sizes.map((size) {
              final isSelected = size == selectedSize;
              return Padding(
                padding: const EdgeInsets.all(4),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: isSelected
                        ? const Color.fromARGB(255, 45, 146, 230)
                        : Colors.white,
                    foregroundColor:
                        isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                  child: Text(size),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});
  @override
  Widget build(BuildContext context) {
    return const Text(
      'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system. '
      'It offers a comfortable fit and a slightly more relaxed appearance than an Oxford shoe, making it suitable '
      'for both formal and casual occasions. Crafted from high-quality leather, it ensures durability, style, and '
      'long-lasting wear, making it an essential piece in any modern wardrobe.',
    );
  }
}

class ActionButtons extends StatelessWidget {
  final Map<String, dynamic> product;

  const ActionButtons({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {
            // handle delete
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () async {
            final updatedProduct = await Navigator.pushNamed(
              context,
              '/add',
              arguments: {
                'title': product['title'],
                'category': product['category'],
                'price': product['price'],
                'description': product['description']
              },
            );

            if (updatedProduct != null &&
                updatedProduct is Map<String, dynamic>) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product updated')),
              );
            }
          },
          child: const Text('Update', style: TextStyle(color: Colors.blue)),
        ),
      ),
    ]);
  }
}
