import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPhoneField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomPhoneField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  String _selectedCode = '+1876';
  final List<String> _codes = ['+1876', '+1658'];

  void _updateNumber() {
    if (widget.onChanged != null) {
      final text = widget.controller?.text ?? '';
      widget.onChanged!('$_selectedCode$text');
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_updateNumber);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateNumber);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label Text
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 6.h),
            child: Text(
              widget.label,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Row(
            children: [
              Container(
                height: 52.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF383838),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Colors.white, width: 1.2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCode,
                    dropdownColor: const Color(0xFF383838),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                    items: _codes.map((code) {
                      return DropdownMenuItem(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedCode = val;
                        });
                        _updateNumber();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
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
                      borderSide: const BorderSide(color: Colors.white, width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: const BorderSide(color: Colors.white, width: 1.8),
                    ),
                  ),
                  onChanged: (val) => _updateNumber(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
