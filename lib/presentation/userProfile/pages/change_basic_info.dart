import 'package:car_parts_app/core/coreWidget/address_autocomplete_field.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/presentation/userProfile/controllers/change_basic_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeBasicInfo extends StatelessWidget {
  const ChangeBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeBasicInfoController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30.sp),
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
                        boxShadow: const [
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
                        child: IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Basic Information Change',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 51.h),

                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 80.h,
                      width: 80.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black26,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0,
                            spreadRadius: 3,
                            offset: Offset(-1, 1),
                            color: Colors.white,
                          ),
                          BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 3,
                            offset: Offset(1, 2),
                            color: Color(0xFF373737),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Obx(() {
                          if (controller.selectedImage.value != null) {
                            return Image.file(
                              controller.selectedImage.value!,
                              fit: BoxFit.cover,
                            );
                          } else if (controller.currentImageUrl.value.isNotEmpty) {
                            return Image.network(
                              controller.currentImageUrl.value,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) => Icon(
                                Icons.person_outline,
                                size: 42.sp,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return Icon(
                              Icons.person_outline,
                              size: 42.sp,
                              color: Colors.white,
                            );
                          }
                        }),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Container(
                        padding: EdgeInsets.all(6.sp),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  'Basic Information',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 16.h),

                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            CustomTextField(
                              label: 'Full Name',
                              hintText: 'Enter your full name',
                              controller: controller.fullNameController,
                            ),
                            SizedBox(height: 12.h),
                            AddressAutocompleteField(
                              controller: controller.addressController,
                              onPlaceSelected: (address, lat, lng) {
                                controller.addressController.text = address;
                                controller.selectedLat.value = lat;
                                controller.selectedLng.value = lng;
                                controller.isAddressSelected.value = true;
                              },
                            ),
                            SizedBox(height: 12.h),
                            CustomTextField(
                              label: 'WhatsApp Number',
                              hintText: 'Enter your WhatsApp Number',
                              controller: controller.whatsappController,
                            ),
                            SizedBox(height: 36.h),
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
                                onPressed: () =>
                                    controller.updateUserProfile(context),
                                child: Obx(
                                  () => controller.isUpdating.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                      : Text(
                                          'Update',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ), // Column
          ), // Padding
        ), // SingleChildScrollView
      ), // SafeArea
    ); // Scaffold
  }
}
