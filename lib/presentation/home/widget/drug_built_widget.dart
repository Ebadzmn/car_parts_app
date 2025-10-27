import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';

class DrugBuiltWidget extends StatelessWidget {
  const DrugBuiltWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        
        child: GradientSlideToAct(
          width: 180.w,
          height: 32.h, // smaller height
          iconSize: 0, 
          borderRadius: 14.r, // smaller draggable icon
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00B4DB),
              Color(0xFF0083B0),
            ],
          ),
          backgroundColor: const Color(0xFF0F172A),
          dragableIcon: Icons.arrow_forward_ios,
        
          dragableIconBackgroundColor: Colors.white,
          text: '        Slide to Go',
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
          onSubmit: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Submitted ✓')),
            );
              
            
          },
        ),
      ),
    );
  }
}