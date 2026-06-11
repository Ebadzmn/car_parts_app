import 'dart:async';
import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/injector/injector.dart' as di;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordController extends GetxController {
  final formKeyForgetPass = GlobalKey<FormState>();
  final formKeyResetPass = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RxBool isLoading = false.obs;
  String savedToken = '';

  // OTP Timer Variables
  RxInt secondsRemaining = 180.obs;
  RxBool isExpired = false.obs;
  Timer? _timer;

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    secondsRemaining.value = 180;
    isExpired.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isExpired.value = true;
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    final minutes = (secondsRemaining.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> sendOtp(BuildContext context) async {
    if (formKeyForgetPass.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        final dio = di.sl<Dio>();
        final response = await dio.post(
          ApiUrls.forgetPassword,
          data: {'email': emailController.text.trim()},
          options: Options(headers: {'Content-Type': 'application/json'}),
        );

        if (response.statusCode == 200) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('OTP sent successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            startTimer();
            context.push(AppRoutes.setOtpPassword, extra: emailController.text.trim());
          }
        }
      } on DioError catch (e) {
        final data = e.response?.data;
        final msg = (data is Map && data['message'] != null) ? data['message'] : e.message;
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed: $msg'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> verifyOtp(BuildContext context, String email, String otp) async {
    if (otp.isEmpty || otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final parsedOtp = int.tryParse(otp);
    if (parsedOtp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP format'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    isLoading.value = true;
    try {
      final dio = di.sl<Dio>();
      final response = await dio.post(
        ApiUrls.verifyOtp,
        data: {'email': email, 'oneTimeCode': parsedOtp},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assume response contains token or the app provides a way to get it.
        // As per instructions, "Save the returned token from the response"
        final data = response.data;
        if (data != null && data['data'] != null) {
          if (data['data'] is String) {
            savedToken = data['data'];
          } else if (data['data'] is Map && data['data']['token'] != null) {
            savedToken = data['data']['token'];
          }
        } else if (data != null && data['token'] != null) {
          savedToken = data['token'];
        }
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP Verified Successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          _timer?.cancel();
          context.push(AppRoutes.set_new_password);
        }
      }
    } on DioError catch (e) {
      final data = e.response?.data;
      final msg = (data is Map && data['message'] != null) ? data['message'] : e.message;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: $msg'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    if (!isExpired.value) return;

    isLoading.value = true;
    try {
      final dio = di.sl<Dio>();
      final response = await dio.post(
        ApiUrls.forgetPassword,
        data: {'email': emailController.text.trim()},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP Resent!'),
              backgroundColor: Colors.amber,
            ),
          );
          startTimer();
        }
      }
    } on DioError catch (e) {
      final data = e.response?.data;
      final msg = (data is Map && data['message'] != null) ? data['message'] : e.message;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: $msg'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    if (formKeyResetPass.currentState?.validate() ?? false) {
      if (newPasswordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      isLoading.value = true;
      try {
        final dio = di.sl<Dio>();
        final response = await dio.post(
          ApiUrls.resetPassword,
          data: {
            'newPassword': newPasswordController.text.trim(),
            'confirmPassword': confirmPasswordController.text.trim()
          },
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': savedToken,
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            
            // Clear temporary data
            emailController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            savedToken = '';

            context.go(AppRoutes.LoginPage);
          }
        }
      } on DioError catch (e) {
        final data = e.response?.data;
        final msg = (data is Map && data['message'] != null) ? data['message'] : e.message;
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed: $msg'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }
  }
}
