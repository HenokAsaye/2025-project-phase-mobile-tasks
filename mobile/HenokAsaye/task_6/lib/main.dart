import 'package:flutter/material.dart';
import 'package:task_6/features/product/presentation/add_product_screen.dart';
import 'package:task_6/features/product/presentation/detail_page.dart';
import 'package:task_6/features/product/presentation/search_product.dart';
import 'package:task_6/core/constants/app_constants.dart';
import 'features/product/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: AppConstants.homeRoute,
      routes: {
        AppConstants.homeRoute: (context) => HomePage(),
        AppConstants.searchRoute: (context) => const ProductSearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppConstants.detailRoute) {
          final args = settings.arguments as Map<String, dynamic>;
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => DetailPage(product: args),
            transitionsBuilder: (_, animation, __, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              var tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: Curves.easeInOut));
              return SlideTransition(position: animation.drive(tween), child: child);
            },
          );
        }
        if (settings.name == AppConstants.addProductRoute) {
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) => AddProductPage(product: args),
            );
        }
        return null;
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
