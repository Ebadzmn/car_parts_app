import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/presentation/tearm_condition/controllers/policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  bool isChecked = false;
  final PolicyController controller = Get.put(PolicyController());

  @override
  void initState() {
    super.initState();
    controller.fetchPolicy(ApiUrls.terms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Example background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
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
                    'Terms and Conditions',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: Colors.green));
                }
                if (controller.hasError.value) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (controller.policyList.isEmpty) {
                  return Center(
                    child: Text(
                      'No terms available at the moment.',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.policyList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final item = controller.policyList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        HtmlWidget(
                          item.content,
                          textStyle: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14.sp,
                            height: 1.5,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
              // Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  Expanded(
                    child: Text(
                      'By using the Platform, you agree to these Terms and Conditions.',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
