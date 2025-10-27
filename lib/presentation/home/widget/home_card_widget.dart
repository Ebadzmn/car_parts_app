// import 'package:car_parts_app/core/config/assets_path.dart';
// import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
// import 'package:car_parts_app/presentation/home/widget/drug_built_widget.dart';
// import 'package:car_parts_app/presentation/home/widget/drug_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';

// class HomeCardWidget extends StatelessWidget {
//   const HomeCardWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         if (state is HomeLoading) {
//           return Center(child: CircularProgressIndicator());
//         }
//         return Container(
//           height: 205.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24.sp),
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 0,
//                 offset: Offset(-1, 0),
//                 spreadRadius: 1,
//                 color: Colors.white38,
//               ),

//               BoxShadow(
//                 blurRadius: 1,
//                 offset: Offset(1, 2),
//                 spreadRadius: 0,
//                 color: Color(0xFF373737),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(left: 15.w, top: 20.h),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,

//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 136.w,
//                       height: 30.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(92.r),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 0,
//                             offset: const Offset(-1, 0),
//                             spreadRadius: 0,
//                             color: Colors.white54,
//                           ),
//                           BoxShadow(
//                             blurRadius: 2,
//                             offset: const Offset(1, 1),
//                             spreadRadius: 0,
//                             color: const Color(0xFF5B5B5B),
//                           ),
//                           BoxShadow(
//                             blurRadius: 0,
//                             offset: const Offset(2, 2),
//                             spreadRadius: 0,
//                             color: const Color(0xFF5B5B5B),
//                           ),
//                         ],
//                       ),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent, // shadow remove
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(92.r),
//                           ),
//                           padding: EdgeInsets.zero, // important!
//                           minimumSize: Size(
//                             double.infinity,
//                             double.infinity,
//                           ), // fills container
//                         ),
//                         onPressed: () {},
//                         child: Center(
//                           // ensures vertical + horizontal centering
//                           child: Text(
//                             'Premium Product',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 10.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                               height: 1, // text vertical alignment fix
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: 15.h),
//                     Text(
//                       'Engine',
//                       style: GoogleFonts.montserrat(
//                         textStyle: TextStyle(
//                           fontStyle: FontStyle.italic,
//                           fontSize: 24,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 3.h),
//                     SizedBox(
//                       width: 140.w,
//                       child: Text(
//                         'Engine is the science of delivering power.',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 10.sp,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
                       

//                       SizedBox(height: 22.h),
                      
//                     ],
//                 ),
//                 Image.asset(AssetsPath.heroparts, height: 170.h, width: 170.w),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_event.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:car_parts_app/core/appRoutes/app_routes.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Container(
          height: 200.h, // height increased to fit drag button
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.sp),
            boxShadow: [
              BoxShadow(
                blurRadius: 0,
                offset: Offset(-1, 0),
                spreadRadius: 1,
                color: Colors.white38,
              ),
              BoxShadow(
                blurRadius: 1,
                offset: Offset(1, 2),
                spreadRadius: 0,
                color: Color(0xFF373737),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 136.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(92.r),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0,
                                offset: const Offset(-1, 0),
                                spreadRadius: 0,
                                color: Colors.white54,
                              ),
                              BoxShadow(
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                                spreadRadius: 0,
                                color: const Color(0xFF5B5B5B),
                              ),
                              BoxShadow(
                                blurRadius: 0,
                                offset: const Offset(2, 2),
                                spreadRadius: 0,
                                color: const Color(0xFF5B5B5B),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(92.r),
                              ),
                              padding: EdgeInsets.zero,
                              minimumSize: Size(double.infinity, double.infinity),
                            ),
                            onPressed: () {},
                            child: Center(
                              child: Text(
                                'Premium Product',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'Engine',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        SizedBox(
                          width: 140.w,
                          child: Text(
                            'Engine is the science of delivering power.',
                            style: GoogleFonts.montserrat(
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        drug_button(),
                      ],
                    ),
                    Image.asset(AssetsPath.heroparts, height: 170.h, width: 165.w),
                  ],
                ),
                // SizedBox(height: 0.h),
                // Drag Button Integration
                // drug_button(),
              ],
            ),
          ),
        );
      },
    );
  }

  BlocProvider<DragBloc> drug_button() {
    return BlocProvider(
                create: (_) => DragBloc(),
                child: SizedBox(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 140.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(49),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: BlocBuilder<DragBloc, DragState>(
                            builder: (context, state) {
                              return Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Positioned(
                                    right: 10,
                                    left: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: const _BlinkingArrow(),
                                  ),
                                  Positioned(
                                    right: 0,
                                    left: 15,
                                    top: 0,
                                    bottom: 0,
                                    child: const _BlinkingArrow(),
                                  ),
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
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: const Icon(Icons.check, color: Colors.white),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10 + state.dx,
                                    top: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onPanUpdate: (details) {
                                        final newDx = (state.dx + details.delta.dx).clamp(
                                          0.0,
                                          110.0,
                                        );
                                        context.read<DragBloc>().add(
                                          DragUpdateEvent(newDx),
                                        );
                                      },
                                      onPanEnd: (_) {
                                        context.read<DragBloc>().add(
                                          DragEndEvent(state.dx),
                                        );
                                      },
                                      child: Container(
                                        width: 30.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.yellow, width: 2),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              blurRadius: 6,
                                              offset: const Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}

// Blinking arrow widget
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
      child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 22),
    );
  }
}
