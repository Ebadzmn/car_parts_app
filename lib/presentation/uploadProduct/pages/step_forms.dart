import 'dart:io';

import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/presentation/uploadProduct/controllers/upload_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StepForms extends StatelessWidget {
  final int step;

  const StepForms({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    switch (step) {
      case 1:
        return const StepOneForm();
      case 2:
        return const StepTwoForm();
      case 3:
        return const StepThreeForm();
      default:
        return const SizedBox.shrink();
    }
  }
}

class StepOneForm extends StatelessWidget {
  const StepOneForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadProductController>();
    return Column(
      children: [
        CustomTextField(
          label: 'Product Title',
          hintText: 'Enter your product title',
          onChanged: (v) => controller.updateFormData({'title': v}),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, bottom: 6.h),
              child: Text(
                'Category',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.formData['category'],
              decoration: InputDecoration(
                hintText: controller.isCategoryLoading.value ? 'Loading...' : 'Select Category',
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: const Color(0xFF383838),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 12.w,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: Colors.white, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: Colors.white, width: 1.8),
                ),
              ),
              dropdownColor: const Color(0xFF383838),
              style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white),
              items: controller.categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat.name, // or cat.id depending on what the API expects
                  child: Text(cat.name),
                );
              }).toList(),
              onChanged: (v) => controller.updateFormData({'category': v}),
            )),
            SizedBox(height: 14.h),
          ],
        ),
        CustomTextField(
          label: 'Price',
          hintText: 'Enter your price',
          keyboardType: TextInputType.number,
          onChanged: (v) => controller.updateFormData({'price': v}),
        ),
        CustomTextField(
          label: 'Condition',
          hintText: 'Enter condition (new, used, refurbished, newly imported)',
          onChanged: (v) => controller.updateFormData({'condition': v}),
        ),
        CustomTextField(
          label: 'Description',
          hintText: 'Enter your product description',
          maxLines: 4,
          onChanged: (v) => controller.updateFormData({'description': v}),
        ),
      ],
    );
  }
}

class StepTwoForm extends StatelessWidget {
  const StepTwoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadProductController>();
    return Column(
      children: [
        CustomTextField(
          label: 'Brand',
          hintText: 'Enter brand (e.g. Toyota)',
          onChanged: (v) => controller.updateFormData({'brand': v}),
        ),
        CustomTextField(
          label: 'Model',
          hintText: 'Enter vehicle model (e.g. Camry)',
          onChanged: (v) => controller.updateFormData({'model': v}),
        ),
        CustomTextField(
          label: 'Year',
          hintText: 'Enter year',
          keyboardType: TextInputType.number,
          onChanged: (v) => controller.updateFormData({'year': v}),
        ),
        CustomTextField(
          label: 'Chassis Number',
          hintText: 'Enter chassis number',
          onChanged: (v) => controller.updateFormData({'chassisNumber': v}),
        ),
        CustomTextField(
          label: 'Parts Number',
          hintText: 'Enter parts number',
          onChanged: (v) => controller.updateFormData({'partsNumber': v}),
        ),
        CustomTextField(
          label: 'Discount (%)',
          hintText: 'Enter discount percentage',
          keyboardType: TextInputType.number,
          onChanged: (v) => controller.updateFormData({'discount': v}),
        ),
        CustomTextField(
          label: 'Warranty',
          hintText: 'Enter warranty details',
          onChanged: (v) => controller.updateFormData({'warranty': v}),
        ),
        CustomTextField(
          label: 'Compatible Car Models',
          hintText: 'Enter car models (comma separated)',
          onChanged: (v) => controller.updateFormData({'carModelsRaw': v}),
        ),
      ],
    );
  }
}

class StepThreeForm extends StatelessWidget {
  const StepThreeForm({super.key});

  Widget _buildUploadBox(String title, VoidCallback onTap, {Widget? preview}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 140.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF363636),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white24, width: 1.w),
            ),
            clipBehavior: Clip.antiAlias, // ensure image stays within corners
            child: preview ?? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 45.h,
                  width: 45.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D5F3A),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.upload_rounded,
                    color: Colors.greenAccent,
                    size: 24.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Click here ',
                        style: GoogleFonts.inter(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextSpan(
                        text: 'to upload or drop media here',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadProductController>();
    
    return Column(
      children: [
        Obx(() {
          Widget? mainPreview;
          if (controller.mainImage.value != null) {
            mainPreview = Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  controller.mainImage.value!,
                  fit: BoxFit.cover,
                ),
                Container(color: Colors.black26), // Slight overlay
                Center(
                  child: Icon(Icons.edit, color: Colors.white, size: 30.sp),
                ),
              ],
            );
          }
          
          return _buildUploadBox(
            'Main Picture Upload',
            () => controller.pickMainImage(),
            preview: mainPreview,
          );
        }),
        SizedBox(height: 16.h),
        Obx(() {
          Widget? galleryPreview;
          if (controller.galleryImages.isNotEmpty) {
            galleryPreview = Stack(
              fit: StackFit.expand,
              children: [
                Row(
                  children: controller.galleryImages.take(3).map((file) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Image.file(
                          file,
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Container(color: Colors.black26),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, color: Colors.white, size: 30.sp),
                      SizedBox(height: 4.h),
                      Text(
                        '${controller.galleryImages.length} images selected',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return _buildUploadBox(
            'Sub Picture Upload',
            () => controller.pickGalleryImages(),
            preview: galleryPreview,
          );
        }),
      ],
    );
  }
}
