import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/presentation/category/controllers/category_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryRequestController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
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
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Category Request',
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Category Name',
                hintText: 'Enter category name',
                controller: controller.nameController,
              ),

              CustomTextField(
                label: 'Description',
                hintText: 'Enter category description',
                controller: controller.descController,
                maxLines: 4,
              ),

              SizedBox(height: 10.h),

              Obx(() => Container(
                height: 44.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: controller.isLoading.value ? Colors.grey : Colors.amber,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: controller.isLoading.value 
                    ? null 
                    : () {
                        // Unfocus keyboard before submitting
                        FocusScope.of(context).unfocus();
                        controller.submitCategoryRequest(context);
                      },
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Request Category',
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
