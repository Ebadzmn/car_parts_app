import 'dart:convert';
import 'dart:io';

import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductController extends GetxController {
  final NetworkCaller _networkCaller = sl<NetworkCaller>();

  // Stepper state
  final RxInt currentStep = 1.obs;

  // Form data
  final RxMap<String, dynamic> formData = <String, dynamic>{}.obs;

  // Image data
  final Rx<File?> mainImage = Rx<File?>(null);
  final RxList<File> galleryImages = <File>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  void updateFormData(Map<String, dynamic> data) {
    formData.addAll(data);
  }

  Future<void> pickMainImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      mainImage.value = File(picked.path);
    }
  }

  Future<void> pickGalleryImages() async {
    final picker = ImagePicker();
    final List<XFile> picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      galleryImages.assignAll(picked.map((x) => File(x.path)).toList());
    }
  }

  Future<void> uploadProduct(BuildContext context) async {
    isLoading.value = true;

    try {
      final data = formData;

      final String title = (data['title'] ?? '').toString().trim();
      final String category = (data['category'] ?? '').toString().trim();
      final String brand = (data['brand'] ?? '').toString().trim();
      final String description = (data['description'] ?? '').toString().trim();
      final String priceStr = (data['price'] ?? '').toString().trim();
      final String condition = (data['condition'] ?? '').toString().trim();

      if (title.isEmpty ||
          category.isEmpty ||
          brand.isEmpty ||
          description.isEmpty ||
          priceStr.isEmpty ||
          mainImage.value == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all required fields and select a main image.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        isLoading.value = false;
        return;
      }

      final double price = double.tryParse(priceStr) ?? 0.0;
      final String chassisNumber = (data['chassisNumber'] ?? '').toString().trim();
      final String warranty = (data['warranty'] ?? '').toString().trim();
      final String discountStr = (data['discount'] ?? '').toString().trim();
      final String carModelsRaw = (data['carModelsRaw'] ?? '').toString().trim();

      final int discount = int.tryParse(discountStr) ?? 0;

      final List<String> carModels = carModelsRaw.isEmpty
          ? <String>[]
          : carModelsRaw
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();

      final productObject = <String, dynamic>{
        'title': title,
        'category': category,
        'brand': brand,
        'description': description,
        'chassisNumber': chassisNumber,
        'condition': condition,
        'warranty': warranty,
        'price': price,
        'discount': discount,
        'productRating': double.tryParse((data['productRating'] ?? '0').toString()) ?? 0.0,
        'sellerRatings': double.tryParse((data['sellerRatings'] ?? '0').toString()) ?? 0.0,
        'isBlocked': (data['isBlocked'] ?? false) == true || (data['isBlocked'] ?? 'false').toString().toLowerCase() == 'true',
        'carModels': carModels, // Just pass the list natively since the whole object is JSON encoded
      };

      final fields = <String, dynamic>{
        'data': jsonEncode(productObject),
      };

      final files = <MapEntry<String, File>>[
        MapEntry<String, File>('mainImage', mainImage.value!),
        ...galleryImages.map((e) => MapEntry<String, File>('galleryImages', e)),
      ];

      final response = await _networkCaller.uploadMultipart(
        ApiUrls.productAdvanced,
        files: files,
        fields: fields,
      );

      if (response.success) {
        final msg = (response.data is Map && response.data['message'] != null)
            ? response.data['message'].toString()
            : 'Product uploaded successfully';
            
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context); // Go back on success
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Failed to upload product'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
