import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/faqs/bloc/faqs_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 30.h,
                    width: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
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
                  SizedBox(width: 10.w),
                  Text(
                    'Change Contact',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Top Quesion',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              BlocBuilder<FaqsBloc, FaqsState>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'How to create a account?',
                        style: GoogleFonts.montserrat(
                          fontSize: 15.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Image.asset(
                        state.isExpanded
                            ? AssetsPath.faqclose
                            : AssetsPath.faqopen,
                        height: 24.h,
                        width: 24.h,
                      ),
                      onExpansionChanged: (expanded) {
                        context.read<FaqsBloc>().add(toggleFaqExpansion());
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Open the Tradebase app to get started and follow the steps. Tradebase doesn’t charge a fee to create or maintain your Tradebase account.',
                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
