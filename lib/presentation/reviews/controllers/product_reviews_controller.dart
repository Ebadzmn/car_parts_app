import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:car_parts_app/data/model/review/review_model.dart';
import 'package:get/get.dart';

class ProductReviewsController extends GetxController {
  final NetworkCaller _networkCaller = sl<NetworkCaller>();

  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isEmpty = false.obs;
  final RxBool hasError = false.obs;

  Future<void> fetchReviews(String productId) async {
    isLoading.value = true;
    hasError.value = false;
    isEmpty.value = false;
    reviews.clear();

    try {
      final response = await _networkCaller.get(
        '${ApiUrls.productReviews}/$productId',
      );

      if (response.success && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> reviewsData = responseData['data'] ?? [];

        if (reviewsData.isEmpty) {
          isEmpty.value = true;
        } else {
          final mappedReviews = reviewsData
              .map((json) => ReviewModel.fromJson(json))
              .toList();
          reviews.assignAll(mappedReviews);
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
}
