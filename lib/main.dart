import 'package:car_parts_app/core/injector/injector.dart' as di;
import 'package:car_parts_app/presentation/auth/pages/login_page.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:car_parts_app/presentation/home/pages/home_page.dart';
import 'package:car_parts_app/presentation/onboard/bloc/onboard_bloc.dart';
import 'package:car_parts_app/presentation/userProfile/pages/change_basic_info.dart';
import 'package:car_parts_app/presentation/userProfile/pages/change_contract.dart';
import 'package:car_parts_app/presentation/userProfile/pages/change_password.dart';
import 'package:car_parts_app/presentation/userProfile/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  di.sl<OnboardBloc>()..add(FetchOnBoardEvent()),
            ),
            BlocProvider(
              create: (context) => di.sl<HomeBloc>()..add(FetchCardEvent()),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(scaffoldBackgroundColor: Color(0xFF212121)),
            debugShowCheckedModeBanner: false,
            // home: ChangeBasicInfo(),
            // home: UserProfile(),
            home: LoginPage(),
          ),
        );
      },
    );
  }
}
