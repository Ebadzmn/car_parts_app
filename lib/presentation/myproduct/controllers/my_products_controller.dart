import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProductsController extends GetxController {
  final NetworkCaller _networkCaller = sl<NetworkCaller>();

  // --- Reactive States ---
  final RxList<ProductModel> products = <ProductModel>[].obs;
  
  final RxBool isLoading = true.obs;
  final RxBool isMoreLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxBool isEmpty = false.obs;

  // --- Pagination trackers ---
  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void onInit() {
    super.onInit();
    fetchMyProducts();
  }

  /// Initial load of products (Page 1)
  Future<void> fetchMyProducts() async {
    isLoading.value = true;
    hasError.value = false;
    isEmpty.value = false;
    _currentPage = 1;
    products.clear();

    try {
      final response = await _networkCaller.get(
        '${ApiUrls.myProducts}?page=$_currentPage',
      );

      if (response.success && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        
        final List<dynamic> productsData = responseData['data'] ?? [];
        final Map<String, dynamic> pagination = responseData['pagination'] ?? {};

        // Parse pagination info
        _totalPages = int.tryParse(pagination['totalPage']?.toString() ?? '1') ?? 1;

        if (productsData.isEmpty) {
          isEmpty.value = true;
        } else {
          final mappedProducts = productsData.map((json) => ProductModel.fromJson(json)).toList();
          products.assignAll(mappedProducts);
        }
      } else {
        hasError.value = true;
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  /// Load the next page of products
  Future<void> fetchMoreMyProducts() async {
    // Return early if we are already loading or if there are no more pages
    if (isMoreLoading.value || _currentPage >= _totalPages) return;

    isMoreLoading.value = true;
    _currentPage++;

    try {
      final response = await _networkCaller.get(
        '${ApiUrls.myProducts}?page=$_currentPage',
      );

      if (response.success && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> productsData = responseData['data'] ?? [];
        final Map<String, dynamic> pagination = responseData['pagination'] ?? {};

        // Update total pages just in case it changed over the network
        _totalPages = int.tryParse(pagination['totalPage']?.toString() ?? _totalPages.toString()) ?? _totalPages;

        if (productsData.isNotEmpty) {
          final mappedProducts = productsData.map((json) => ProductModel.fromJson(json)).toList();
          products.addAll(mappedProducts);
        }
      } else {
        // Typically pagination error can just show a snackbar or fail silently instead of replacing the entire screen
        Get.snackbar(
          'Error',
          'Failed to load more products',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Exception',
        'Check your connection and try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isMoreLoading.value = false;
    }
  }
}
