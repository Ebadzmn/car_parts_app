import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryRequestController extends GetxController {
  final NetworkCaller _networkCaller = sl<NetworkCaller>();

  final nameController = TextEditingController();
  final descController = TextEditingController();

  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    super.onClose();
  }

  Future<void> submitCategoryRequest(BuildContext context) async {
    final name = nameController.text.trim();
    final description = descController.text.trim();

    if (name.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _networkCaller.post(
        ApiUrls.categoryRequest,
        body: {
          "name": name,
          "description": description,
        },
      );

      if (response.success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category request submitted successfully'),
              backgroundColor: Colors.green,
            ),
          );
          // Clear form & navigate back
          nameController.clear();
          descController.clear();
          Navigator.of(context).pop();
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Submission failed.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check your internet connection and try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
