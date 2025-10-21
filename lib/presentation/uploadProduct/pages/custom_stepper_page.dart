import 'package:car_parts_app/presentation/uploadProduct/pages/step_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/stepper_bloc.dart';
import '../bloc/stepper_event.dart';
import '../bloc/stepper_state.dart';

class CustomHorizontalStepperPage extends StatelessWidget {
  const CustomHorizontalStepperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StepperBloc(),
      child: BlocBuilder<StepperBloc, StepperState>(
        builder: (context, state) {
          final bloc = context.read<StepperBloc>();
          double screenWidth = MediaQuery.of(context).size.width;
          double progressWidth =
              ((state.currentStep - 1) / (3 - 1)) *
              (screenWidth - 32.w); // responsive padding

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.w), // responsive padding
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 🔹 Header
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
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
                                  size: 18.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Flexible(
                              child: Text(
                                'Basic Information Change',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // 🔹 Stepper UI
                      SizedBox(
                        height: 60.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Grey Line
                            Positioned(
                              top: 10.h,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 3.h,
                                color: Colors.grey[300],
                              ),
                            ),
                            // Green Line
                            Positioned(
                              top: 10.h,
                              left: 0,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                height: 3.h,
                                width: progressWidth,
                                color: Colors.green,
                              ),
                            ),
                            // Circles
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(3, (index) {
                                int step = index + 1;
                                bool isActive = step <= state.currentStep;
                                return Column(
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? Colors.green
                                            : Colors.grey.shade300,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "$step",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: isActive
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Step $step",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isActive
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // 🔹 Form Body
                      StepForms(
                        step: state.currentStep,
                        onChanged: (data) => bloc.add(
                          UpdateFormEvent({...state.formData, ...data}),
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // 🔹 Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
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
                            onPressed: state.currentStep > 1
                                ? () => bloc.add(PreviousStepEvent())
                                : null,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  "Back",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Next Button
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
                            onPressed: state.currentStep < 3
                                ? () => bloc.add(NextStepEvent())
                                : null,
                            child: Row(
                              children: [
                                Text(
                                  state.currentStep == 3 ? "Finish" : "Next",
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
