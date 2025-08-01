import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> products = [
    {
      "name": "Derby Leather Shoes",
      "price": 120,
      "image": 'assets/Img/shoe.jpg',
      "category": "Men's shoe",
      "rating": 4.0,
    },
    {
      "name": "Derby Leather Shoes",
      "price": 120,
      "image": 'assets/Img/shoe.jpg',
      "category": "Men's shoe",
      "rating": 4.0,
    },
    {
      "name": "Derby Leather Shoes",
      "price": 120,
      "image": 'assets/Img/shoe.jpg',
      "category": "Men's shoe",
      "rating": 4.0,
    },
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,'/add');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
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
              ),

              const SizedBox(height: 20),

              // Section Title
              const Text(
                "Available Products",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              // Product List
              Expanded(
                child: ListView.builder(
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) =>
                      productCard(widget.products[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap:(){
        Navigator.pushNamed(context,'/detail',arguments: product);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                product['image'],
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
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
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        "\$${product['price']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
      
                  // Category & Rating
                  Row(
                    children: [
                      Text(
                        product['category'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            "(${product['rating']})",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
