import 'package:car_parts_app/core/injector/injector.dart' as di;
import 'package:car_parts_app/presentation/details/bloc/review_submit_bloc.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:car_parts_app/presentation/details/widget/rating_star_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingPopUpWidget extends StatelessWidget {
  final String productId;
  const RatingPopUpWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    int selectedRating = 0;

    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider<ReviewSubmitBloc>(
      create: (_) => di.sl<ReviewSubmitBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<ReviewSubmitBloc, ReviewSubmitState>(
            listener: (context, state) {
              if (state is ReviewSuccess) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh product details to update rating
                try {
                  context.read<DetailsBloc>().add(
                    GetProductDetailsEvent(productId),
                  );
                } catch (_) {}
              } else if (state is ReviewFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: screenHeight >= 1024 ? 350.h : 320.h,
                  width: 330.w,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
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
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Rate the product?',
                        style: GoogleFonts.montserrat(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Star rating
                      RatingStars(
                        maxRating: 5,
                        iconSize: 40.0,
                        onRatingChanged: (rating) {
                          selectedRating = rating;
                        },
                      ),

                      SizedBox(height: 12.h),

                      // Comment field
                      TextFormField(
                        controller: commentController,
                        maxLines: 3,
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write a review',
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF383838),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 12.w,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.8,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Submit button
                      BlocBuilder<ReviewSubmitBloc, ReviewSubmitState>(
                        builder: (context, state) {
                          final isLoading = state is ReviewSubmitting;

                          return Container(
                            height: 34.h,
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
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      // Validation
                                      if (selectedRating == 0) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Please select a rating',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }
                                      if (commentController.text
                                          .trim()
                                          .isEmpty) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Please write a review comment',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      context.read<ReviewSubmitBloc>().add(
                                        SubmitProductReview(
                                          productId: productId,
                                          rating: selectedRating,
                                          comment: commentController.text
                                              .trim(),
                                        ),
                                      );
                                    },
                              child: isLoading
                                  ? SizedBox(
                                      height: 18.h,
                                      width: 18.h,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      'Submit',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          );
                        },
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
