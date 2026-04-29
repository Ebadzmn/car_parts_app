import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/coreWidget/address_autocomplete_field.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/core/coreWidget/custom_phone_field.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:car_parts_app/core/coreWidget/custom_loading_dialog.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  // ✅ Controllers and ValueNotifier as final (Stateless-safe)
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final ValueNotifier<bool> isChecked = ValueNotifier(false);
  final ValueNotifier<String> completeContactNumber = ValueNotifier('');

  // Address-related state
  final ValueNotifier<String> selectedAddress = ValueNotifier('');
  final ValueNotifier<double> selectedLat = ValueNotifier(0.0);
  final ValueNotifier<double> selectedLng = ValueNotifier(0.0);
  final ValueNotifier<bool> isAddressSelected = ValueNotifier(false);

  // ✅ submitForm takes context as parameter
  void submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (!isChecked.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept Terms and Conditions')),
      );
      return;
    }

    final model = SignupModel(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      whatsappNumber: completeContactNumber.value.isEmpty ? contactController.text.trim() : completeContactNumber.value,
      password: passwordController.text,
      address: addressController.text.trim(),
      lat: selectedLat.value,
      lng: selectedLng.value,
    );

    // ✅ Use correct BuildContext from button (not null)
    context.read<AuthBloc>().add(SignUpEvent(signupModel: model));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18.sp),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showCustomLoadingDialog(context, message: 'Creating account...');
            } else {
              if (Navigator.canPop(context)) Navigator.pop(context);
            }

            if (state is SignUpSuccess) {
              final message = state.response['message'] ?? 'Signup success';
              final email = emailController.text.trim();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              context.push(AppRoutes.OtpPage, extra: email);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 34.h),
                Image.asset(AssetsPath.newLogo, width: 150.w, height: 150.h),

                // Full Name
                CustomTextField(
                  controller: fullNameController,
                  label: 'Full Name',
                  hintText: 'Please enter your full name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full name is required';
                    }
                    return null;
                  },
                ),

                // Email
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Please enter your email address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                // Contact Number (Optional)
                CustomPhoneField(
                  controller: contactController,
                  label: 'Whatsapp Number',
                  hintText: 'Please enter your whatsapp number',
                  onChanged: (phone) {
                    completeContactNumber.value = phone.completeNumber;
                  },
                ),

                // Address with Autocomplete
                AddressAutocompleteField(
                  controller: addressController,
                  onPlaceSelected: (address, lat, lng) {
                    selectedAddress.value = address;
                    selectedLat.value = lat;
                    selectedLng.value = lng;
                    isAddressSelected.value = true;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),

                // Password
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  hintText: 'Please enter your password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                // Terms Checkbox
                ValueListenableBuilder<bool>(
                  valueListenable: isChecked,
                  builder: (context, value, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: value,
                          onChanged: (newValue) =>
                              isChecked.value = newValue ?? false,
                        ),
                        Expanded(
                          child: Text(
                            'By creating an account you agree to our Terms and Conditions',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 12.h),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () => submitForm(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // Already have account?
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(color: Colors.white),
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
                            context.push(AppRoutes.LoginPage);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
