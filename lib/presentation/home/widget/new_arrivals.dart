import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class NewArrivalsWidget extends StatelessWidget {
  final String title;
  NewArrivalsWidget({super.key, required this.title});

  // Dummy static data (replace with API or Bloc later)
  final List<Map<String, dynamic>> dummyCars = [
    {
      "carName": "BMW M4",
      "carCondition": "New",
      "price": "32.60",
    },
    {
      "carName": "Toyota Premio",
      "carCondition": "Used",
      "price": "12.40",
    },
    {
      "carName": "Tesla Model 3",
      "carCondition": "Refurb",
      "price": "22.10",
    },
    {
      "carName": "Ford Mustang",
      "carCondition": "New",
      "price": "35.00",
    },
  ];

  // Helper function for text gradient
  List<Color> getGradientColors(String condition) {
    switch (condition) {
      case "New":
        return [Colors.green, Colors.white];
      case "Used":
        return [Colors.red, Colors.white];
      case "Refurb":
        return [Color(0xFFE7BE00), Colors.white];
      default:
        return [Color(0xFFE7BE00), Colors.white];
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = 1.sw;

    int crossAxisCount = screenWidth < 600
        ? 2
        : screenWidth < 900
            ? 3
            : 3;

    double childAspectRatio = screenWidth < 600 ? 2 / 2.9 : 2.2 / 3.2;

    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ===== HEADER =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                'See More',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          /// ===== GRID STATIC =====
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: dummyCars.length,
            itemBuilder: (context, index) {
              final item = dummyCars[index];

              return GestureDetector(
                onTap: () {
                  context.push(AppRoutes.detailsScreen);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.2),
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2E2C2A),
                        Color(0xFF131313),
                        Color(0xFF1D1D20),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Car name
                        Text(
                          item["carName"],
                          style: GoogleFonts.montserrat(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.grey,
                            color: Colors.grey,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        /// Car Condition
                        Text(
                          item["carCondition"],
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: getGradientColors(item["carCondition"]),
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                              ).createShader(
                                Rect.fromLTWH(0, 0, 200, 20),
                              ),
                          ),
                        ),

                        SizedBox(height: 8.h),

                        /// Image
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.black,
                            ),
                            child: Image.asset(
                              AssetsPath.cardtire,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        SizedBox(height: 8.h),

                        /// PRICE + ICON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PRICE',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  item["price"],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: [
                                          Color(0xFF5BB349),
                                          Colors.white,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                      ).createShader(
                                        Rect.fromLTWH(0, 0, 200, 20),
                                      ),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              AssetsPath.cardbtn,
                              width: 30.w,
                              height: 30.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
