import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  bool isChecked = false;

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
              // Terms and Conditions Text
              RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    const TextSpan(
                      text:
                          "Please read these Terms and Conditions carefully before using our Auto Parts mobile application or website (“the Platform”).\n\n",
                    ),
                    TextSpan(
                      text: "1. Acceptance of Terms\n",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0.sp,
                      ),
                    ),
                    const TextSpan(
                      text:
                          "By creating an account and using the Platform, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.\n\n",
                    ),
                    TextSpan(
                      text: "2. User Accounts\n",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0.sp,
                      ),
                    ),
                    const TextSpan(
                      text:
                          "By creating an account, you agree to provide accurate, complete, and current information. You are responsible for safeguarding your account details.\n\n",
                    ),
                    TextSpan(
                      text: "3. Privacy Policy\n",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0.sp,
                      ),
                    ),
                    const TextSpan(
                      text:
                          "We collect and use personal information in accordance with our Privacy Policy. By using the Platform, you consent to these practices.\n\n",
                    ),
                    TextSpan(
                      text: "4. Governing Law\n",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0.sp,
                      ),
                    ),
                    const TextSpan(
                      text:
                          "These Terms shall be governed by the laws of [Insert Country/Region]. Continued use implies acceptance of any updates.\n\n",
                    ),
                  ],
                ),
              ),
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
