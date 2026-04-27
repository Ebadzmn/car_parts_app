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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0,
                            spreadRadius: 1,
                            offset: const Offset(0, 1),
                            color: Colors.grey,
                          ),
                          BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: const Offset(2, 2),
                            color: const Color(0xFF373737),
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

              // ── Category Name Field ──────────────────────────────────
              CustomTextField(
                label: 'Category Name',
                hintText: 'Enter category name',
                controller: controller.nameController,
                onChanged: controller.onNameChanged,
              ),

              // ── Icon Suggestion Section ──────────────────────────────
              _IconSuggestionSection(controller: controller),

              SizedBox(height: 14.h),

              // ── Description Field ────────────────────────────────────
              CustomTextField(
                label: 'Description',
                hintText: 'Enter category description',
                controller: controller.descController,
                maxLines: 4,
              ),

              SizedBox(height: 10.h),

              // ── Image Upload Section ─────────────────────────────────
              _CategoryImagePicker(controller: controller),

              SizedBox(height: 10.h),

              // ── Submit Button ────────────────────────────────────────
              Obx(() => Container(
                    height: 44.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: controller.isLoading.value
                          ? Colors.grey
                          : Colors.amber,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              controller.submitCategoryRequest(context);
                            },
                      child: controller.isLoading.value
                          ? SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CircularProgressIndicator(
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

// ─────────────────────────────────────────────────────────────────────────────
// Icon Suggestion Section Widget
// ─────────────────────────────────────────────────────────────────────────────

class _IconSuggestionSection extends StatelessWidget {
  final CategoryRequestController controller;

  const _IconSuggestionSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final icons = controller.suggestedIcons;
      final selected = controller.selectedIcon.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label row
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2A2400), Color(0xFF1A1A1A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.yellow.withOpacity(0.4), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.auto_awesome, color: Colors.yellow, size: 14.sp),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Choose an Icon',
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: Colors.yellow,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (selected != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.yellow, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(selected, color: Colors.yellow, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'Selected',
                          style: GoogleFonts.montserrat(
                            fontSize: 10.sp,
                            color: Colors.yellow,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Icon grid
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Colors.yellow.withOpacity(0.35), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.06),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: EdgeInsets.all(10.w),
            child: icons.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        'No matching icons found',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: icons.length,
                    itemBuilder: (context, index) {
                      final item = icons[index];
                      final iconData = item['icon'] as IconData;
                      final iconName = item['name'] as String;
                      final isSelected =
                          controller.selectedIconName.value == iconName;

                      return GestureDetector(
                        onTap: () =>
                            controller.selectIcon(iconData, iconName),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.yellow.withOpacity(0.18)
                                : const Color(0xFF2C2C2C),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isSelected ? Colors.yellow : Colors.white12,
                              width: isSelected ? 1.8 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.yellow.withOpacity(0.25),
                                      blurRadius: 6,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconData,
                                color: isSelected ? Colors.yellow : Colors.white38,
                                size: 22.sp,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                iconName.replaceAll('_', ' '),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 7.sp,
                                  color: isSelected
                                      ? Colors.yellow
                                      : Colors.white38,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 8.w, top: 6.h),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 10.sp, color: Colors.yellow.withOpacity(0.6)),
                SizedBox(width: 4.w),
                Text(
                  'Icons update as you type a category name above',
                  style: GoogleFonts.montserrat(
                    fontSize: 10.sp,
                    color: Colors.yellow.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Image Picker Widget
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryImagePicker extends StatelessWidget {
  final CategoryRequestController controller;

  const _CategoryImagePicker({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
          child: Row(
            children: [
              Text(
                'Category Image',
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: Colors.yellow.withOpacity(0.4)),
                ),
                child: Text(
                  'Optional',
                  style: GoogleFonts.montserrat(
                    fontSize: 9.sp,
                    color: Colors.yellow,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Image box
        Obx(() {
          final image = controller.categoryImage.value;
          return GestureDetector(
            onTap: controller.pickCategoryImage,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: image != null
                      ? Colors.yellow.withOpacity(0.5)
                      : Colors.white12,
                  width: image != null ? 1.5 : 1,
                ),
                boxShadow: image != null
                    ? [
                        BoxShadow(
                          color: Colors.yellow.withOpacity(0.08),
                          blurRadius: 12,
                          spreadRadius: 1,
                        )
                      ]
                    : [],
              ),
              clipBehavior: Clip.antiAlias,
              child: image != null
                  // ── Preview ──────────────────────────────────────────
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(image, fit: BoxFit.cover),
                        Container(color: Colors.black38),
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: GestureDetector(
                            onTap: controller.removeCategoryImage,
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.85),
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Icon(Icons.close, color: Colors.white, size: 14.sp),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit, color: Colors.white, size: 14.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  'Change Image',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  // ── Placeholder ───────────────────────────────────────
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 46.h,
                          width: 46.h,
                          decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(0.12),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.yellow.withOpacity(0.4), width: 1),
                          ),
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Colors.yellow,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Tap to upload ',
                                style: GoogleFonts.montserrat(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ),
                              TextSpan(
                                text: 'a category image',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white54,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Max 10MB • JPG, PNG',
                          style: GoogleFonts.montserrat(
                            fontSize: 10.sp,
                            color: Colors.white30,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        }),
      ],
    );
  }
}
