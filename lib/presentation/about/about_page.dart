import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutEPartsPage extends StatelessWidget {
  const AboutEPartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Optional background
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
                    'About E-Parts',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // About Section
              Text(
                "About E-Parts",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "At E-Parts, we believe your vehicle deserves nothing less than excellence. "
                "Our mission is to deliver premium car parts, tires, and accessories crafted for precision, durability, and style. "
                "Every product we offer meets global quality standards, ensuring the perfect balance of performance and reliability for every drive.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Mission
              Text(
                "Our Mission",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "To deliver premium car parts and a seamless shopping experience, ensuring every vehicle runs at its best.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // What We Offer
              Text(
                "What We Offer",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "• Genuine parts for all major car brands.\n"
                "• Fast delivery and easy returns.\n"
                "• Secure payment and real-time order tracking.\n"
                "• 24/7 customer support.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Why Choose Us
              Text(
                "Why Choose Us",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "We believe in trust, transparency, and technology. Every product is carefully verified to meet global standards of quality and performance.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Vision
              Text(
                "Our Vision",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "To become the most reliable auto parts platform that connects every car owner with the parts they need — anytime, anywhere.",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 15.h),

              // Opening Hours
              Text(
                "Opening Hours",
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Sat - Sun 12:00 AM - 12:00 PM",
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
