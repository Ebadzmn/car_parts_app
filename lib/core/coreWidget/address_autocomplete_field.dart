import 'dart:async';
import 'package:car_parts_app/data/data_source/remote/places_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressAutocompleteField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String address, double lat, double lng) onPlaceSelected;
  final String? Function(String?)? validator;

  AddressAutocompleteField({
    super.key,
    required this.controller,
    required this.onPlaceSelected,
    this.validator,
  });

  final PlacesService _placesService = PlacesService();
  final ValueNotifier<List<Map<String, String>>> _suggestions =
      ValueNotifier([]);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _isSelected = ValueNotifier(false);

  // Static debounce map to avoid instance field immutability issue
  static Timer? _debounce;

  void _onChanged(String value) {
    // Mark as not selected whenever user types
    _isSelected.value = false;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (value.trim().isEmpty) {
      _suggestions.value = [];
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      _isLoading.value = true;
      final results = await _placesService.getAutocompleteSuggestions(value);
      _suggestions.value = results;
      _isLoading.value = false;
    });
  }

  Future<void> _onSuggestionTap(Map<String, String> suggestion) async {
    final placeId = suggestion['placeId'] ?? '';
    final description = suggestion['description'] ?? '';

    // Immediately fill text & close dropdown
    controller.text = description;
    _suggestions.value = [];

    // Fetch details for lat/lng
    final details = await _placesService.getPlaceDetails(placeId);
    if (details != null) {
      _isSelected.value = true;
      onPlaceSelected(
        details['address'] as String,
        details['lat'] as double,
        details['lng'] as double,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 6.h),
            child: Text(
              'Address',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          /// Text Field
          TextFormField(
            controller: controller,
            onChanged: _onChanged,
            validator: validator,
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Search for your address',
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: const Color(0xFF383838),
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.h,
                horizontal: 12.w,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                    const BorderSide(color: Colors.white, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                    const BorderSide(color: Colors.white, width: 1.8),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.8),
              ),
              suffixIcon: ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (_, loading, __) {
                  if (loading) {
                    return Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SizedBox(
                        height: 16.h,
                        width: 16.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.amber,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),

          /// Suggestions Dropdown
          ValueListenableBuilder<List<Map<String, String>>>(
            valueListenable: _suggestions,
            builder: (context, suggestions, _) {
              if (suggestions.isEmpty) return const SizedBox.shrink();

              return Container(
                margin: EdgeInsets.only(top: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF444444),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                constraints: BoxConstraints(maxHeight: 200.h),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  itemCount: suggestions.length,
                  separatorBuilder: (_, __) => Divider(
                    color: const Color(0xFF444444),
                    height: 1,
                    indent: 12.w,
                    endIndent: 12.w,
                  ),
                  itemBuilder: (context, index) {
                    final suggestion = suggestions[index];
                    return InkWell(
                      onTap: () => _onSuggestionTap(suggestion),
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.amber,
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                suggestion['description'] ?? '',
                                style: GoogleFonts.montserrat(
                                  fontSize: 11.sp,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
