import 'dart:convert';
import 'dart:io';

import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/data/model/category/category_model.dart';
import 'package:car_parts_app/domain/usecase/category/category_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class UploadProductController extends GetxController {
  final NetworkCaller _networkCaller = sl<NetworkCaller>();
  final CategoryUsecase _categoryUsecase = sl<CategoryUsecase>();

  // Stepper state
  final RxInt currentStep = 1.obs;

  // Form data
  final RxMap<String, dynamic> formData = <String, dynamic>{}.obs;

  // Image data
  final Rx<File?> mainImage = Rx<File?>(null);
  final RxList<File> galleryImages = <File>[].obs;

  // Categories
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isCategoryLoading = false.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isCategoryLoading.value = true;
    final result = await _categoryUsecase.call();
    result.fold(
      (l) => Get.snackbar('Error', 'Failed to load categories'),
      (r) => categories.assignAll(r),
    );
    isCategoryLoading.value = false;
  }

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
      // Limit to 5 images as per requirements
      final List<File> limitedImages = picked.map((x) => File(x.path)).take(5).toList();
      galleryImages.assignAll(limitedImages);
      
      if (picked.length > 5) {
        Get.snackbar(
          'Limit Exceeded',
          'Only the first 5 images were selected.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<File?> _compressFile(File file) async {
    final tempDir = await getTemporaryDirectory();
    final String fileName = p.basenameWithoutExtension(file.path);
    final String outPath = p.join(tempDir.path, "${fileName}_compressed.jpg");

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 50, // Reduced quality further
      minWidth: 1024, // Added resizing constraints
      minHeight: 1024,
      format: CompressFormat.jpeg,
    );

    if (result == null) return null;
    return File(result.path);
  }

  Future<void> uploadProduct(BuildContext context) async {
    isLoading.value = true;

    try {
      final data = formData;

      final String title = (data['title'] ?? '').toString().trim();
      final String category = (data['category'] ?? '').toString().trim();
      final String description = (data['description'] ?? '').toString().trim();
      final String priceStr = (data['price'] ?? '').toString().trim();
      final String condition = (data['condition'] ?? '').toString().trim().toLowerCase();

      if (title.isEmpty ||
          category.isEmpty ||
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
      final String brand = (data['brand'] ?? '').toString().trim();
      final String model = (data['model'] ?? '').toString().trim();
      final String year = (data['year'] ?? '').toString().trim();
      final String chassisNumber = (data['chassisNumber'] ?? '').toString().trim();
      final String partsNumber = (data['partsNumber'] ?? '').toString().trim();
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

      // IMPORTANT: Data must be a stringified JSON as per Field 1 requirements
      final productObject = <String, dynamic>{
        'title': title,
        'category': category,
        'price': price,
        'condition': condition,
        'description': description,
        'brand': brand,
        'model': model,
        'year': year,
        'chassisNumber': chassisNumber,
        'partsNumber': partsNumber,
        'carModels': carModels,
        'warranty': warranty,
        'discount': discount,
        'isBlocked': false,
      };

      final fields = <String, dynamic>{
        'data': jsonEncode(productObject),
      };

      // Compress Main Image
      final File? compressedMain = await _compressFile(mainImage.value!);
      if (compressedMain == null) {
        throw Exception('Failed to compress main image');
      }

      // Compress Gallery Images
      final List<File> compressedGallery = [];
      for (var img in galleryImages) {
        final compressed = await _compressFile(img);
        if (compressed != null) {
          compressedGallery.add(compressed);
        }
      }

      final files = <MapEntry<String, File>>[
        MapEntry<String, File>('mainImage', compressedMain),
        ...compressedGallery.map((e) => MapEntry<String, File>('galleryImages', e)),
      ];

      final response = await _networkCaller.uploadMultipart(
        ApiUrls.productAdvanced,
        files: files,
        fields: fields,
      );

      if (response.success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context); // Navigate back on success
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
