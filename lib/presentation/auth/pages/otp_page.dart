import 'dart:async';
import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/data/model/auth/verify_account_model.dart';
import 'package:car_parts_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  int _secondsRemaining = 180;
  Timer? _timer;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 180;
    _isExpired = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        setState(() {
          _isExpired = true;
        });
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _verifyOtp(BuildContext context) {
    FocusScope.of(context).unfocus();

    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      errorMessage.value = 'Please enter the OTP code';
      return;
    } else if (otp.length != 6) {
      errorMessage.value = 'OTP must be 6 digits';
      return;
    }

    // safe parse
    final parsed = int.tryParse(otp);
    if (parsed == null) {
      errorMessage.value = 'Invalid OTP format';
      return;
    }

    errorMessage.value = null;

    final verifyAccountModel = VerifyAccountModel(
      email: widget.email,
      oneTimeCode: parsed,
    );

    context.read<AuthBloc>().add(
      VerifyAccountEvent(verifyAccountModel: verifyAccountModel),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    errorMessage.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please check your email',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.h),
              SizedBox(height: 30.sp),

              // OTP Input Field
              PinCodeTextField(
                appContext: context,
                controller: _otpController,
                length: 6,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                enableActiveFill: true,
                autoDisposeControllers: false,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 40.h,
                  fieldWidth: 40.w,
                  inactiveColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.transparent,
                  activeColor: Colors.transparent,
                ),
                animationDuration: const Duration(milliseconds: 200),
                onChanged: (value) {
                  // correct length check to 4
                  if (value.length == 6) {
                    errorMessage.value = null;
                  }
                },
              ),

              // Error Message
              ValueListenableBuilder<String?>(
                valueListenable: errorMessage,
                builder: (context, message, _) {
                  if (message == null) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _isExpired ? Colors.redAccent : Colors.amber,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18.sp,
                      color: _isExpired ? Colors.redAccent : Colors.amber,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _isExpired
                          ? 'Code expired!'
                          : 'Code expires in: $_formattedTime',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: _isExpired ? Colors.redAccent : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              // BlocConsumer: button-local loading indicator (no fullscreen)
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is VerifyAccountSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${state.response['message']}')),
                    );
                    context.go(AppRoutes.LoginPage);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AuthLoading;

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
                      onPressed: isLoading ? null : () => _verifyOtp(context),
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 16.h,
                                  width: 16.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Verifying...',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Continue',
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
              SizedBox(height: 12.h),

              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login tapped!')),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
