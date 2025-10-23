import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class ReportPopup extends StatelessWidget {
  const ReportPopup({super.key});

  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => DetailsBloc(),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: screenHeight >= 1024 ? 500.h : 400.h,
            width: 330.w,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF202020),
                  Color(0xFF373737),
                  Color(0xFF202020),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<DetailsBloc, DetailsState>(
                  builder: (context, state) {
                    final currentIndex = state.currentIndex;
                    return Row(
                      children: [
                        _buildTab(
                          context: context,
                          text: 'Report Product',
                          index: 0,
                          isSelected: currentIndex == 0,
                        ),
                        SizedBox(width: 10.w),
                        _buildTab(
                          context: context,
                          text: 'Report Seller',
                          index: 1,
                          isSelected: currentIndex == 1,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10.h),
                BlocBuilder<DetailsBloc, DetailsState>(
                  builder: (context, state) {
                    final currentIndex = state.currentIndex;
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: currentIndex == 0
                          ? Column(
                            children: [
                              CustomTextField(label: 'Product Description', hintText: 'Enter product report description...' , maxLines: 4,
            
                                // key: const ValueKey('product'),
                                
                              ),
                              SizedBox(height: 6.h),
            
                              _buildUploadSection(title: 'Attach Picture', icon: Icons.upload_rounded)
                             
                            ],
                          )
                          : Column(
                            children: [
                              CustomTextField(label: 'Description', hintText: 'Enter seller report description..' , maxLines: 4,
            
                                // key: const ValueKey('product'),
                                
                              ),
                              SizedBox(height: 4.h),
            
                              _buildUploadSection(title: 'Attach Picture', icon: Icons.upload_rounded)
                             
                            ],
                          )
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Container(
                    height: 38.h,
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
                      onPressed: () {},
                      child: Text(
                        'Submit',
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required String text,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => context.read<DetailsBloc>().add(SelectTabEvent(index)),
      child: Column(
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 3.h,
            width: 120.w,
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }
}

  Widget _buildUploadSection({required String title, required IconData icon}) {
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
        DottedBorder(
          options: RoundedRectDottedBorderOptions(

            radius: Radius.circular(16.r),
            strokeWidth: 1.w,
            color: Colors.white,
            dashPattern: const [10, 4],
            

          ),
          child: Container(
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12.r),
              // border: Border.all(color: Colors.white24, width: 1 ,),
              
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 45.h,
                  width: 45.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D5F3A),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.greenAccent, size: 24.sp),
                ),
                SizedBox(height: 8.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Click here ',
                        style: GoogleFonts.inter(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'to upload or drop media here',
                        style: GoogleFonts.inter(color: Colors.white70),
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
