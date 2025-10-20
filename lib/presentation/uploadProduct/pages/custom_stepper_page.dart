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
              ((state.currentStep - 1) / (3 - 1)) * (screenWidth - 60);

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 12.0,
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
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
                          SizedBox(width: 10.w),
                          Text(
                            'Basic Information Change',
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
                    // 🔹 Stepper UI
                    SizedBox(
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Grey Line
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 3,
                              color: Colors.grey[300],
                            ),
                          ),
                          // Blue Line
                          Positioned(
                            top: 10,
                            left: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: 3,
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
                                    height: 20,
                                    width: 20,
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
                                          fontSize: 10,
                                          color: isActive
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Step $step",
                                    style: TextStyle(
                                      fontSize: 12,
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

                    const SizedBox(height: 30),

                    // 🔹 Form Body (changes by step)
                    StepForms(
                      step: state.currentStep,
                      onChanged: (data) => bloc.add(
                        UpdateFormEvent({...state.formData, ...data}),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🔹 Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: state.currentStep > 1
                              ? () => bloc.add(PreviousStepEvent())
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Back",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 100),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
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
          );
        },
      ),
    );
  }
}
