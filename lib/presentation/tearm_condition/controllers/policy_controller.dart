import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:car_parts_app/data/model/policy/policy_model.dart';
import 'package:get/get.dart';

class PolicyController extends GetxController {
  final NetworkCaller _networkCaller = sl<NetworkCaller>();

  final RxList<PolicyModel> policyList = <PolicyModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> fetchPolicy(String endpoint) async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      final response = await _networkCaller.get(endpoint);

      if (response.success && response.data != null) {
        final data = response.data!['data'];
        if (data is List) {
          final List<PolicyModel> items = data
              .map((e) => PolicyModel.fromJson(e as Map<String, dynamic>))
              .where((element) => element.isActive == null || element.isActive == true)
              .toList();
          policyList.assignAll(items);
        } else {
          policyList.clear();
        }
      } else {
        hasError.value = true;
        errorMessage.value = response.message ?? 'Failed to load content';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load content: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
