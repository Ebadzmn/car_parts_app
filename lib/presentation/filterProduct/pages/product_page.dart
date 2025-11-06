import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/filterProduct/pages/filter_page.dart';
import 'package:car_parts_app/presentation/home/widget/home_car_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
      
      drawer: FilterDrawer(categories: categories, brands: brands),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     // Open the drawer
                //     _scaffoldKey.currentState?.openDrawer();
                //   },
                //   child: const Text('Open Filter Drawer'),
                // ),
                    
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Product' , textAlign: TextAlign.left, style: GoogleFonts.montserrat(fontSize: 24 , fontWeight: FontWeight.w600 , color: Colors.white , fontStyle: FontStyle.italic),)),
                  SizedBox(height: 10.h),
                Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Box
            Expanded(
        flex: 10,
        child: Container(
          height: 40.h,
          child: SearchWidget(),
        ),
            ),
        
            SizedBox(width: 10.w),
        
            // Filter Button
            Flexible(
        flex: 2,
        child: Container(
          height: 45.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: IconButton(
            icon: Image.asset(
              AssetsPath.filterPng,
              color: Colors.white,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        // HomeCarCardWidget(title: 'New Arrival',)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
