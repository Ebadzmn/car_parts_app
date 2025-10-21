import 'package:car_parts_app/presentation/filterProduct/pages/filter_page.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  // GlobalKey to control the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final categories = [
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Sports',
    'Toys',
    'Automotive',
    'Books',
    'Beauty',
    'Music',
    'Furniture',
  ];

  final brands = [
    'Apple',
    'Samsung',
    'Nike',
    'Adidas',
    'Sony',
    'LG',
    'Dell',
    'HP',
    'Asus',
    'Puma',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign key to Scaffold
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.white,
      ),
      drawer: FilterDrawer(categories: categories, brands: brands),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Open the drawer
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Text('Open Filter Drawer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Close the drawer if it is open
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Close Drawer'),
            ),
          ],
        ),
      ),
    );
  }
}
