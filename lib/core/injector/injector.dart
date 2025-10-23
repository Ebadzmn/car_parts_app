import 'package:car_parts_app/data/repositories/category_repositories_impl.dart';
import 'package:car_parts_app/data/repositories/onb_repositories_impl.dart';
import 'package:car_parts_app/data/repositories/product_repositories_impl.dart';
import 'package:car_parts_app/domain/repositories/category/category_repositories.dart';
import 'package:car_parts_app/domain/repositories/onboard/onboard_repositories.dart';
import 'package:car_parts_app/domain/repositories/product/product_repositories.dart';
import 'package:car_parts_app/domain/usecase/category/category_usecase.dart';
import 'package:car_parts_app/domain/usecase/onboard/onboard_usecase.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:car_parts_app/presentation/category/bloc/category_bloc.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:car_parts_app/presentation/faqs/bloc/faqs_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:car_parts_app/presentation/onboard/bloc/onboard_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Registering the OnboardBloc with its required OnboardUsecase dependency
  sl.registerFactory(() => OnboardBloc(onboardUsecase: sl()));

  sl.registerLazySingleton(() => OnboardUsecase(sl()));

  // Registering the OnboardRepositories with its implementation
  sl.registerLazySingleton<OnboardRepositories>(() => OnbRepositoriesImpl());

  sl.registerFactory(() => HomeBloc(productUsecase: sl()));
  sl.registerFactory(() => DetailsBloc());
  sl.registerFactory(() => FaqsBloc());
  sl.registerFactory(() => DragBloc());

  sl.registerFactory(() => CategoryBloc(categoryUsecase: sl()));

  sl.registerLazySingleton(() => ProductUsecase(sl()));
  sl.registerLazySingleton(() => CategoryUsecase(sl()));

  sl.registerLazySingleton<ProductRepositories>(
    () => ProductRepositoriesImpl(),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoriesImpl(),
  );
}
