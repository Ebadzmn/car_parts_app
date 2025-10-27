import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_event.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DragButtonWidget extends StatelessWidget {
  const DragButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = 1.sw;
    final screenHeight = 1.sh;
    return BlocProvider(
      create: (_) => DragBloc(),
      child: BlocListener<DragBloc, DragState>(
        listenWhen: (prev, curr) => curr.shouldNavigate,
        listener: (context, state) {
          if (state.shouldNavigate) {
            context.push(AppRoutes.detailsScreen).then((_) {
              // ফিরে এলে আবার আগের অবস্থায় নিয়ে আসা
              context.read<DragBloc>().add(const DragUpdateEvent(0));
            });
          }
        },
        child: Scaffold(
          

          backgroundColor: Colors.transparent,
          body: Row(
            children: [
              Container(
                // width: screenWidth <600 ? screenWidth * 0.8 : 600 * 0.8,
                // height: screenHeight  <600 ? screenHeight * 0.045 : 600 * 0.1,
                width: 150,
                height: 70,
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
                        // Right target button
                        Positioned(
                          right: 10,
                          top: screenHeight * 0.01,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                          
                        // Draggable Left button
                        Positioned(
                          left: 10 + state.dx,
                          top: screenHeight * 0.01,
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
                              width: 40,
                              height: 40,
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

// import 'package:car_parts_app/core/appRoutes/app_routes.dart';
// import 'package:car_parts_app/presentation/home/bloc/drug_bloc.dart';
// import 'package:car_parts_app/presentation/home/bloc/drug_event.dart';
// import 'package:car_parts_app/presentation/home/bloc/drug_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class DragButtonWidget extends StatelessWidget {
//   const DragButtonWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => DragBloc(),
//       child: BlocListener<DragBloc, DragState>(
//         listenWhen: (prev, curr) => curr.shouldNavigate,
//         listener: (context, state) {
//           if (state.shouldNavigate) {
//             context.push(AppRoutes.detailsScreen).then((_) {
//               // ফিরে এলে আবার আগের অবস্থায় নিয়ে আসা
//               context.read<DragBloc>().add(const DragUpdateEvent(0));
//             });
//           }
//         },
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: SafeArea(
//             top: false, // ✅ উপরে থাকবে, vanish করবে না
//             child: Padding(
//               padding: EdgeInsets.only(top: 40.h), // ✅ manually নিচে নামানো হয়েছে
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 160.w,
//                     height: 70.h,
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(49),
//                       border: Border.all(color: Colors.white, width: 1.5),
//                     ),
//                     child: BlocBuilder<DragBloc, DragState>(
//                       builder: (context, state) {
//                         return Stack(
//                           alignment: Alignment.centerLeft,
//                           children: [
//                             Positioned(
//                               right: 10,
//                               left: 0,
//                               child: const _BlinkingArrow(),
//                             ),
//                             Positioned(
//                               right: 0,
//                               left: 15,
//                               child: const _BlinkingArrow(),
//                             ),
//                             // ✅ Right target button
//                             Positioned(
//                               right: 10,
//                               top: 10,
//                               child: Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   shape: BoxShape.circle,
//                                   border:
//                                       Border.all(color: Colors.white, width: 2),
//                                 ),
//                                 child:
//                                     const Icon(Icons.check, color: Colors.white),
//                               ),
//                             ),

//                             // ✅ Draggable Left button
//                             Positioned(
//                               left: 10 + state.dx,
//                               top: 10,
//                               child: GestureDetector(
//                                 onPanUpdate: (details) {
//                                   final newDx =
//                                       (state.dx + details.delta.dx).clamp(
//                                     0.0,
//                                     100.0, // drag limit
//                                   );
//                                   context
//                                       .read<DragBloc>()
//                                       .add(DragUpdateEvent(newDx));
//                                 },
//                                 onPanEnd: (_) {
//                                   context
//                                       .read<DragBloc>()
//                                       .add(DragEndEvent(state.dx));
//                                 },
//                                 child: Container(
//                                   width: 40,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                         color: Colors.yellow, width: 2),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.2),
//                                         blurRadius: 6,
//                                         offset: const Offset(2, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: const Icon(
//                                     Icons.check,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _BlinkingArrow extends StatefulWidget {
//   const _BlinkingArrow();

//   @override
//   State<_BlinkingArrow> createState() => _BlinkingArrowState();
// }

// class _BlinkingArrowState extends State<_BlinkingArrow>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _opacity;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat(reverse: true);
//     _opacity = Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _opacity,
//       child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 22),
//     );
//   }
// }
