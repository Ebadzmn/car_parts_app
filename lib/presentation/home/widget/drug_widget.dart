import 'package:car_parts_app/presentation/home/bloc/drug_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_event.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DragButtonWidget extends StatelessWidget {
  const DragButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DragBloc(),
      child: BlocListener<DragBloc, DragState>(
        listenWhen: (prev, curr) => curr.shouldNavigate,
        listener: (context, state) {
          if (state.shouldNavigate) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NextPage()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: 175,
              height: 60,
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
                        child: _BlinkingArrow(),
                      ),
                      Positioned(
                        right: 0,
                        left: 15,
                        top: 0,
                        bottom: 0,
                        child: _BlinkingArrow(),
                      ),
                      // Right target button
                      Positioned(
                        right: 10,
                        top: 10,
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
                        top: 10,
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

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          '🎉 Navigated!',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
    );
  }
}
