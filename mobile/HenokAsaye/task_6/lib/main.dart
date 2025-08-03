import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_6/features/product/presentation/add_product_screen.dart';
import 'package:task_6/features/product/presentation/detail_page.dart';
import 'package:task_6/features/product/presentation/search_product.dart';
import 'package:task_6/core/constants/app_constants.dart';
import 'package:task_6/core/di/service_locator.dart';
import 'package:task_6/features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductBloc>(
      future: ServiceLocator().productBloc,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        }

        final bloc = snapshot.data!;
        
        return BlocProvider(
          create: (context) => bloc,
          child: MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            initialRoute: AppConstants.homeRoute,
            routes: {
              AppConstants.homeRoute: (context) => const HomePage(),
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
          ),
        );
      },
    );
  }
}
