import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                              color: Colors.grey,
                            ),
          
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(2, 2),
                              color: Color(0xFF373737),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Add New Category',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
              CustomTextField(label: 'Category Name', hintText: 'Enter category name'),
               
              CustomTextField(label: 'Reason', hintText: 'Enter reason'),


              Container(
                      height: 44.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.amber,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                            context.pop();

                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}