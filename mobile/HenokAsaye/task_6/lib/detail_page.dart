import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BackButton(),
              const SizedBox(height: 16),
              ProductImage(imagePath: product['image']),
              const SizedBox(height: 16),
              ProductInfo(
                name: product['name'],
                price: product['price'],
                category: product['category'],
                rating: product['rating'],
              ),
              const SizedBox(height: 16),
              const SizeRange(),
              const SizedBox(height: 16),
              ProductDescription(),
              const SizedBox(height: 24),
              const ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imagePath;
  const ProductImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(imagePath),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final String name;
  final int price;
  final String category;
  final double rating;

  const ProductInfo({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              '\$$price',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey[500],
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey[500],
                fontSize: 13,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(
                  '($rating)',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
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
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              // Implement delete logic here
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
            onPressed: () {
              // Implement update logic here
            },
            child: const Text('Update', style: TextStyle(color: Colors.blue)),
          ),
        ),
      ],
    );
  }
}
