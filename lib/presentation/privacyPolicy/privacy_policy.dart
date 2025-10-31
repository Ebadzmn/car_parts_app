import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // optional background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button + Title
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
                            offset: const Offset(0, 1),
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
                    'Privacy Policy',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Effective Date
              Text(
                "Effective Date: [Insert Date]",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),

              // Intro
              Text(
                "At E PARTS, your privacy is our priority. This policy explains how we collect, use, and protect your information when you use our app or services.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),

              // Section 1
              Text(
                "1. Information We Collect",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "We collect data to provide and improve your experience:\n\n"
                "• Personal Info: Name, email, phone number, address.\n"
                "• Usage Info: App interactions, preferences, and search history.\n"
                "• Transaction Info: Payment details (handled securely via trusted gateways).",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Section 2
              Text(
                "2. How We Use Your Data",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Your data helps us:\n\n"
                "• Process and deliver your orders.\n"
                "• Improve app performance and product recommendations.\n"
                "• Send updates, offers, and important notifications.\n"
                "• Maintain security and prevent fraud.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Section 3
              Text(
                "3. Sharing Your Data",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "We do not sell your personal information.\n\n"
                "We may share limited data with:\n"
                "• Trusted service providers (payments, delivery, analytics).\n"
                "• Legal authorities, if required by law.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Section 4
              Text(
                "4. Data Security",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "We use encryption and secure servers to protect your information.\nHowever, no online system is 100% secure, so we recommend keeping your login details private.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Section 5
              Text(
                "5. Your Rights",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "You can:\n\n"
                "• View, edit, or delete your account information.\n"
                "• Opt out of promotional notifications.\n"
                "• Request data removal by contacting our support.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Section 6
              Text(
                "6. Cookies",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "We use cookies to enhance your experience and remember your preferences.\nYou can disable them anytime in your settings.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Section 7
              Text(
                "7. Updates to This Policy",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "We may update this policy occasionally. The latest version will always be available inside the app.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
