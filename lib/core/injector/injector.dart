import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/coreWidget/bloc/navbar_bloc.dart';
import 'package:car_parts_app/data/data_source/remote/auth_remoteDatasource.dart';
import 'package:car_parts_app/data/data_source/remote/category_remoteDataSource.dart';
import 'package:car_parts_app/data/data_source/remote/product_remoteDataSource.dart';
import 'package:car_parts_app/data/repositories/auth/auth_repositories_impl.dart';
import 'package:car_parts_app/data/repositories/category_repositories_impl.dart';
import 'package:car_parts_app/data/repositories/onb_repositories_impl.dart';
import 'package:car_parts_app/data/repositories/product_repositories_impl.dart';
import 'package:car_parts_app/domain/repositories/auth/auth_repositories.dart';
import 'package:car_parts_app/domain/repositories/category/category_repositories.dart';
import 'package:car_parts_app/domain/repositories/onboard/onboard_repositories.dart';
import 'package:car_parts_app/domain/repositories/product/product_repositories.dart';
import 'package:car_parts_app/domain/usecase/auth/auth_usecase.dart';
import 'package:car_parts_app/domain/usecase/category/category_usecase.dart';
import 'package:car_parts_app/domain/usecase/onboard/onboard_usecase.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:car_parts_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:car_parts_app/presentation/category/bloc/category_bloc.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:car_parts_app/presentation/faqs/bloc/faqs_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:car_parts_app/presentation/onboard/bloc/onboard_bloc.dart';
import 'package:car_parts_app/presentation/productByCategory/bloc/product_advamce_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Registering the Dio instance with its base options
  sl.registerLazySingleton(() => Dio(BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      )));

  // Registering the OnboardBloc with its required OnboardUsecase dependency
  sl.registerFactory(() => OnboardBloc(onboardUsecase: sl()));

  sl.registerLazySingleton(() => OnboardUsecase(sl()));

  // Registering the OnboardRepositories with its implementation
  sl.registerLazySingleton<OnboardRepositories>(() => OnbRepositoriesImpl());

  sl.registerFactory(() => HomeBloc(productUsecase: sl()));
  sl.registerFactory(() => DetailsBloc());
  sl.registerFactory(() => FaqsBloc());
  sl.registerFactory(() => DragBloc());
  sl.registerFactory(() => BottomNavBloc());
  sl.registerFactory(() => AuthBloc(sl(),sl()));
  sl.registerFactory(() => CategoryBloc(categoryUsecase: sl()));
  sl.registerFactory(() => ProductAdvamceBloc(sl()));


  sl.registerLazySingleton(() => ProductUsecase(sl()));
  sl.registerLazySingleton(() => CategoryUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(authRepositories: sl()));
  sl.registerLazySingleton(() => VerifyAccountUsecase(authRepositories: sl()));



  sl.registerLazySingleton<ProductRepositories>(
    () => ProductRepositoriesImpl( sl()),
  );
  sl.registerLazySingleton<AuthRepositories>(
    () => AuthRepositoriesImpl( sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoriesImpl( sl()),
  );
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemotedatasourceImpl(
       sl(),

    ),
  );

  sl.registerLazySingleton<CategoryRemotedatasource>(
    () => CategoryRemotedatasourceImpl( sl()),
  );

  sl.registerLazySingleton<ProductRemotedatasource>(
    () => ProductRemotedatasourceImpl( sl()),
  );
}
