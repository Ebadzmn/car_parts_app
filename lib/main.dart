import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/coreWidget/bloc/navbar_bloc.dart';
import 'package:car_parts_app/core/injector/injector.dart' as di;
import 'package:car_parts_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:car_parts_app/presentation/category/bloc/category_bloc.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:car_parts_app/presentation/faqs/bloc/faqs_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:car_parts_app/presentation/home/pages/main_screen.dart';
import 'package:car_parts_app/presentation/onboard/bloc/onboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // Set system navigation bar color normal (non-transparent)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent, // optional
    statusBarIconBrightness: Brightness.light,
  ));

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
              create: (context) => di.sl<OnboardBloc>()..add(FetchOnBoardEvent()),
            ),
            BlocProvider(
              create: (context) => di.sl<HomeBloc>()..add(FetchCardEvent()),
            ),
            BlocProvider(
              create: (context) => di.sl<DetailsBloc>()..add(CaroselPageChanged(0)),
            ),
            BlocProvider(create: (context) => di.sl<FaqsBloc>()),
            BlocProvider(create: (context) => di.sl<DragBloc>()),
            BlocProvider(create: (context) => di.sl<BottomNavBloc>()),
            BlocProvider(
              create: (context) => di.sl<CategoryBloc>()..add(FetchCategoriesEvent()),
            ),
            BlocProvider(
              create: (context) => di.sl<AuthBloc>(),
            ),
          ],
          child: MaterialApp.router(
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF212121),
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            builder: (context, child) {
              return child!; // set MainScreen as home
            },
          ),
        );
      },
    );
  }
}
