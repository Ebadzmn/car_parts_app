import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/app_color.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/injector/injector.dart'; // sl
import 'package:car_parts_app/data/data_source/local/auth_local_datasource.dart';

import 'package:car_parts_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:car_parts_app/presentation/userProfile/bloc/user_profile_bloc.dart'; // ensure this exists
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  Future<void> _checkLocalTokenAndDispatch(BuildContext context) async {
    try {
      final authLocal = sl<AuthLocalDatasource>();
      final token = await authLocal.getToken();

      if (token == null || token.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(AppRoutes.LoginPage);
        });
        return;
      }

      // dispatch auth check if needed
      final bloc = context.read<AuthBloc>();
      if (bloc.state is! AuthLoading && bloc.state is! SignInSuccess) {
        bloc.add(CheckInStatusEvent());
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRoutes.LoginPage);
      });
    }
  }

  void _showLoadingDialog(BuildContext context) {
    if (!Navigator.of(context).canPop()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    }
  }

  void _hideDialogIfOpen(BuildContext context) {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {
    // run token check once after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocalTokenAndDispatch(context);
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          _showLoadingDialog(context);
        } else {
          _hideDialogIfOpen(context);
        }

        if (state is AuthError) {
          _hideDialogIfOpen(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(AppRoutes.LoginPage);
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                // show profile only when authenticated
                if (authState is SignInSuccess) {


                  final screenHeight = 1.sh;

                  return Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 0,
                                    spreadRadius: 1,
                                    offset: Offset(0, 1),
                                    color: Colors.grey,
                                  ),
                                  BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    offset: Offset(2, 2),
                                    color: Color(0xFF373737),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () => context.pop(),
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'User Profile',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),

                        // --- Profile area: listens to UserProfileBloc ---
                        BlocBuilder<UserProfileBloc, UserProfileState>(
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50.r,
                                    backgroundColor: Colors.grey.shade300,
                                    child: const CircularProgressIndicator(),
                                  ),
                                  SizedBox(height: 14.h),
                                  Text(
                                    'Loading profile...',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            }

                            if (state is UserLoaded) {
                              final profile = state.profileEntity;
                              final imageUrl = profile.image;



                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50.r,
                                    backgroundImage: (imageUrl.isNotEmpty)
                                        ? NetworkImage(imageUrl)
                                        : const AssetImage(AssetsPath.newLogo)
                                              as ImageProvider,
                                  ),
                                  SizedBox(height: 14.h),
                                  Text(
                                    profile.name.isNotEmpty
                                        ? profile.name
                                        : 'Logged in',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    profile.email.isNotEmpty
                                        ? profile.email
                                        : 'No email provided',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),

                                ],
                              );
                            }

                            if (state is UserError) {
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50.r,
                                    backgroundImage: const AssetImage(
                                      AssetsPath.newLogo,
                                    ),
                                  ),
                                  SizedBox(height: 14.h),
                                  Text(
                                    'Failed to load profile\n${state.message}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  ElevatedButton(
                                    onPressed: () => context
                                        .read<UserProfileBloc>()
                                        .add(const GetUserProfileEvent()),
                                    child: const Text('Retry'),
                                  ),
                                ],
                              );
                            }

                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage: const AssetImage(
                                    AssetsPath.newLogo,
                                  ),
                                ),
                                SizedBox(height: 14.h),
                                Text(
                                  'Logged in',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        SizedBox(height: 24.h),

                        Container(
                          height: screenHeight > 1000 ? 260.h : 200.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColor.secondary,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => context.push(AppRoutes.changeBasicInfo),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Basic Information',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        'Update Basic Information',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                InkWell(
                                  onTap: () => context.push(AppRoutes.changeContact),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Contact',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        'Update contact information',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                InkWell(
                                  onTap: () => context.push(AppRoutes.changePassword),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Change Password',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // otherwise show loader while resolving auth status
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
