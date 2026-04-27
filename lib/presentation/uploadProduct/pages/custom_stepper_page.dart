import 'package:car_parts_app/presentation/uploadProduct/controllers/upload_product_controller.dart';
import 'package:car_parts_app/presentation/uploadProduct/pages/step_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHorizontalStepperPage extends StatefulWidget {
  const CustomHorizontalStepperPage({super.key});

  @override
  State<CustomHorizontalStepperPage> createState() => _CustomHorizontalStepperPageState();
}

class _CustomHorizontalStepperPageState extends State<CustomHorizontalStepperPage> {
  late final UploadProductController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(UploadProductController());
  }

  @override
  void dispose() {
    Get.delete<UploadProductController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 0,
                                spreadRadius: 1,
                                offset: Offset(0, 1),
                                color: Colors.grey,
                              ),
                              const BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(2, 2),
                                color: Color(0xFF373737),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Upload Product',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Obx(() {
                  final currentStep = controller.currentStep.value;
                  final double screenWidth = MediaQuery.of(context).size.width;
                  final double progressWidth = ((currentStep - 1) / (3 - 1)) * (screenWidth - 48.w);

                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // Background Line
                        Positioned(
                          top: 16.h,
                          left: 20.w,
                          right: 20.w,
                          child: Container(
                            height: 2.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        // Progress Line
                        Positioned(
                          top: 16.h,
                          left: 20.w,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            height: 2.h,
                            width: progressWidth,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFD100), Color(0xFFFFB800)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFD100).withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        // Steps
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            final step = index + 1;
                            final bool isCompleted = step < currentStep;
                            final bool isActive = step == currentStep;
                            
                            return Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 32.h,
                                  width: 32.h,
                                  decoration: BoxDecoration(
                                    color: (isActive || isCompleted) 
                                      ? const Color(0xFFFFD100) 
                                      : const Color(0xFF2C2C2C),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isActive 
                                        ? Colors.white 
                                        : (isCompleted ? const Color(0xFFFFD100) : Colors.white.withOpacity(0.1)),
                                      width: isActive ? 2 : 1,
                                    ),
                                    boxShadow: isActive ? [
                                      BoxShadow(
                                        color: const Color(0xFFFFD100).withOpacity(0.4),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      )
                                    ] : [],
                                  ),
                                  child: Center(
                                    child: isCompleted
                                      ? Icon(Icons.check, size: 18.sp, color: Colors.black)
                                      : Text(
                                          '$step',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: (isActive || isCompleted) ? Colors.black : Colors.white54,
                                          ),
                                        ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  step == 1 ? 'Basic Info' : (step == 2 ? 'Details' : 'Media'),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10.sp,
                                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                    color: isActive ? const Color(0xFFFFD100) : Colors.grey,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 30.h),
                
                // Form content updates based on step
                Obx(() => StepForms(step: controller.currentStep.value)),
                
                SizedBox(height: 30.h),
                Obx(() {
                  final isUploading = controller.isLoading.value;
                  final currentStep = controller.currentStep.value;
                  
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 14.w,
                          ),
                        ),
                        onPressed: currentStep > 1 && !isUploading ? () => controller.previousStep() : null,
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Back',
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD100).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD100),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              elevation: 0,
                            ),
                            onPressed: isUploading
                                ? null
                                : () {
                                    if (currentStep < 3) {
                                      controller.nextStep();
                                    } else {
                                      controller.uploadProduct(context);
                                    }
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isUploading && currentStep == 3) ...[
                                  SizedBox(
                                    height: 18.h,
                                    width: 18.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                ],
                                Text(
                                  currentStep == 3 
                                    ? (isUploading ? 'UPLOADING...' : 'SUBMIT PRODUCT') 
                                    : 'CONTINUE TO STEP ${currentStep + 1}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 18.sp,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
