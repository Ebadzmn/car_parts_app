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
                  final double progressWidth = ((currentStep - 1) / (3 - 1)) * (screenWidth - 32.w);

                  return SizedBox(
                    height: 60.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 10.h,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 3.h,
                            color: Colors.grey[300],
                          ),
                        ),
                        Positioned(
                          top: 10.h,
                          left: 0,
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 400,
                            ),
                            height: 3.h,
                            width: progressWidth,
                            color: Colors.green,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            final step = index + 1;
                            final bool isActive = step <= currentStep;
                            return Column(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.green : Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$step',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: isActive ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Step $step',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isActive ? Colors.green : Colors.grey,
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
                          children: [
                            if (isUploading && currentStep == 3) ...[
                              SizedBox(
                                height: 16.h,
                                width: 16.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                            ],
                            Text(
                              currentStep == 3 ? (isUploading ? 'Uploading product...' : 'Submit') : 'Next',
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                          ],
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
