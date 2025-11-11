// lib/presentation/details/report_popup.dart
import 'dart:io';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:car_parts_app/presentation/details/bloc/report_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ReportPopup extends StatelessWidget {
  final ProductDetailsUsecase usecase;
  // NOTE: kept controller here to satisfy stateless requirement.
  // In production consider passing controller from parent or make StatefulWidget to dispose controller.
  final TextEditingController descController = TextEditingController();

  ReportPopup({Key? key, required this.usecase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DetailsBloc(productDetailsUsecase: usecase)
            ..add(CaroselPageChanged(0)),
        ),
        BlocProvider(
          create: (_) => ReportBloc(picker: ImagePicker()),
        ),
      ],
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: screenHeight >= 1024 ? 520.h : 460.h,
            width: 360.w,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF202020), Color(0xFF373737), Color(0xFF202020)],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<DetailsBloc, DetailsState>(
                  builder: (context, state) {
                    final currentIndex = state.selectedTabIndex;
                    return Row(
                      children: [
                        _buildTab(context, 'Report Product', 0, currentIndex == 0),
                        SizedBox(width: 10.w),
                        _buildTab(context, 'Report Seller', 1, currentIndex == 1),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: BlocBuilder<DetailsBloc, DetailsState>(
                    builder: (context, dState) {
                      final currentIndex = dState.selectedTabIndex;
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: currentIndex == 0
                            ? _buildReportForm(context, 'Product Description',
                                'Enter product report description...')
                            : _buildReportForm(context, 'Description',
                                'Enter seller report description...'),
                      );
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                BlocConsumer<ReportBloc, ReportState>(
                  listenWhen: (previous, current) =>
                      previous.submitted != current.submitted ||
                      previous.errorMessage != current.errorMessage,
                  listener: (context, state) {
                    if (state.submitted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Report submitted successfully')),
                      );
                      Navigator.of(context).pop();
                    } else if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      height: 44.h,
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
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                final desc = descController.text.trim();
                                // UI-level validation (optional, bloc also validates)
                                if (desc.length < 3) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Description too short')));
                                  return;
                                }
                                if (context.read<ReportBloc>().state.imagePath == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please attach an image')));
                                  return;
                                }
                                context.read<ReportBloc>().add(SubmitReportEvent(desc));
                              },
                        child: state.isSubmitting
                            ? SizedBox(width: 20.w, height: 20.w, child: const CircularProgressIndicator())
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
  }

  Widget _buildTab(BuildContext context, String text, int index, bool isSelected) {
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

  Widget _buildReportForm(BuildContext context, String label, String hint) {
    return Column(
      key: ValueKey(label),
      children: [
        CustomTextField(
          controller: descController,
          label: label,
          hintText: hint,
          maxLines: 4,
        ),
        SizedBox(height: 8.h),
        _buildUploadSection(context, 'Attach Picture', Icons.upload_rounded),
      ],
    );
  }

  Widget _buildUploadSection(BuildContext context, String title, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        // BlocBuilder with ValueKey ensures proper rebuild when imagePath changes
        BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            // debug: remove in production
            print('[ReportPopup] BlocBuilder imagePath -> ${state.imagePath}');
            return DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(16.r),
                strokeWidth: 1.w,
                color: Colors.white,
                dashPattern: const [10, 4],
              ),
              child: Container(
                // force subtree replacement when imagePath changes
                key: ValueKey(state.imagePath ?? 'empty_upload_area'),
                padding: EdgeInsets.all(8.w),
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: state.imagePath == null
                    ? _buildEmptyUploadArea(context, icon)
                    : _buildSingleThumbnail(context, File(state.imagePath!)),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmptyUploadArea(BuildContext context, IconData icon) {
    return InkWell(
      onTap: () => _showPickOptions(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 45.h,
            width: 45.h,
            decoration: const BoxDecoration(color: Color(0xFF2D5F3A), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.greenAccent, size: 24.sp),
          ),
          SizedBox(height: 8.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Click here ',
                  style: GoogleFonts.inter(color: Colors.greenAccent, fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: 'to upload or take a photo',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleThumbnail(BuildContext context, File file) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.file(file, width: 80.w, height: 80.h, fit: BoxFit.cover),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Selected image',
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
              SizedBox(height: 8.h),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _showPickOptions(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white12, shadowColor: Colors.transparent),
                    child: Text('Replace', style: GoogleFonts.inter(color: Colors.white)),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: () => context.read<ReportBloc>().add(const RemoveImageEvent()),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, shadowColor: Colors.transparent),
                    child: Text('Remove', style: GoogleFonts.inter(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  void _showPickOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: Text('Pick from gallery', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<ReportBloc>().add(PickImageFromGalleryEvent());
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: Text('Take a photo', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<ReportBloc>().add(PickImageFromCameraEvent());
                },
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.white),
                title: Text('Cancel', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
