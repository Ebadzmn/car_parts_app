import 'dart:async';
import 'package:get/get.dart';
import 'package:car_parts_app/domain/usecase/category/category_usecase.dart';
import 'package:car_parts_app/data/model/category/category_model.dart';
import 'package:car_parts_app/core/injector/injector.dart';

class HomeCardController extends GetxController {
  final CategoryUsecase _categoryUsecase = sl<CategoryUsecase>();
  
  var categories = <CategoryModel>[].obs;
  var currentIndex = 0.obs;
  var isLoading = true.obs;
  
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    isLoading.value = true;
    final result = await _categoryUsecase.call();
    result.fold(
      (failure) {
        isLoading.value = false;
      },
      (data) {
        if (data.isNotEmpty) {
          categories.value = data;
        }
        isLoading.value = false;
        _startTimer();
      }
    );
  }

  void _startTimer() {
    if (categories.isEmpty) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (categories.isNotEmpty) {
        currentIndex.value = (currentIndex.value + 1) % categories.length;
      }
    });
  }

  CategoryModel? get currentCategory {
    if (categories.isEmpty) return null;
    return categories[currentIndex.value];
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
