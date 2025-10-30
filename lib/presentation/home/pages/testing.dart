import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_event.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_state.dart';
import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class SellerCardWidget extends StatelessWidget {
  const SellerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      
      decoration: BoxDecoration(
        color: const Color(0xFF5BB349),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Become a Seller button
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF69B859), Color(0xFF6FBE5F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Become a Seller',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Heading text
              Text(
                'Drive Your \nBusiness Forward',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              // Subtext
              Text(
                'Sell today, reach \neverywhere.',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Drag Button
              BlocProvider(
                create: (_) => DragBloc(),
                child: SizedBox(
                  width: 150.w,
                  height: 40.h,
                  child: BlocListener<DragBloc, DragState>(
                    listenWhen: (prev, curr) => curr.shouldNavigate,
                    listener: (context, state) {
                      if (state.shouldNavigate) {
                        context.push(AppRoutes.detailsScreen).then((_) {
                          context.read<DragBloc>().add(const DragUpdateEvent(0));
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(49),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: BlocBuilder<DragBloc, DragState>(
                        builder: (context, state) {
                          return Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              // Left blinking arrow
                              Positioned(
                                left: 60.w,
                                top: 0,
                                bottom: 0,
                                child: const _BlinkingArrow(),
                              ),
                              // Right blinking arrow
                              Positioned(
                                right: 60.w,
                                top: 0,
                                bottom: 0,
                                child: const _BlinkingArrow(),
                              ),
                              // Draggable check icon
                              Positioned(
                                left: 10 + state.dx,
                                top: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    final newDx = (state.dx + details.delta.dx)
                                        .clamp(0.0, 110.0);
                                    context
                                        .read<DragBloc>()
                                        .add(DragUpdateEvent(newDx));
                                  },
                                  onPanEnd: (_) {
                                    context
                                        .read<DragBloc>()
                                        .add(DragEndEvent(state.dx));
                                  },
                                  child: Container(
                                    width: 30.w,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.yellow, width: 2),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              // Right static check icon
                              Positioned(
                                right: 10,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(Icons.check,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Seller image
         Expanded(
           child: Image.asset(
              AssetsPath.sellarpic,
              height: 250.h,
              width: 140.w,
              fit: BoxFit.cover,
            ),
         ),
        ],
      ),
    );
  }
}

// Blinking Arrow Widget
class _BlinkingArrow extends StatefulWidget {
  const _BlinkingArrow();

  @override
  State<_BlinkingArrow> createState() => _BlinkingArrowState();
}

class _BlinkingArrowState extends State<_BlinkingArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: const Icon(Icons.arrow_forward_ios,
          color: Colors.black, size: 20),
    );
  }
}
