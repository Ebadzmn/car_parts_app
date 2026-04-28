import 'dart:io';
import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:car_parts_app/data/data_source/remote/places_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';

class ChangeBasicInfoController extends GetxController {
  final NetworkCaller _networkCaller = sl<NetworkCaller>();
  final ImagePicker _picker = ImagePicker();

  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final whatsappController = TextEditingController();
  final RxString completeWhatsappNumber = ''.obs;

  final RxDouble selectedLat = 0.0.obs;
  final RxDouble selectedLng = 0.0.obs;
  final RxBool isAddressSelected = false.obs;

  final RxBool isLoading = true.obs;
  final RxBool isUpdating = false.obs;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString currentImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    addressController.dispose();
    whatsappController.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    try {
      final response = await _networkCaller.get(ApiUrls.userProfile);

      if (response.success && response.data != null) {
        final data = response.data!['data'] ?? response.data!;

        fullNameController.text = data['name'] ?? '';
        whatsappController.text = data['whatsappNumber']?.toString() ?? '';
        completeWhatsappNumber.value = data['whatsappNumber']?.toString() ?? '';
        currentImageUrl.value = data['image']?.toString() ?? data['profilePicture']?.toString() ?? '';

        String address = data['address'] ?? '';

        // Use coordinates to reverse geocode if address is not directly provided
        if (data['coordinates'] != null) {
          final lat = (data['coordinates']['lat'] as num?)?.toDouble();
          final lng = (data['coordinates']['lng'] as num?)?.toDouble();

          if (lat != null && lng != null) {
            selectedLat.value = lat;
            selectedLng.value = lng;
            isAddressSelected.value = true;

            if (address.isEmpty) {
              final location = await PlacesService().reverseGeocode(lat, lng);
              if (location != null) {
                address = location;
              }
            }
          }
        }

        addressController.text = address;
      }
    } catch (e) {
      debugPrint("Error fetching user profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserProfile(BuildContext context) async {
    final name = fullNameController.text.trim();
    final whatsappNumber = completeWhatsappNumber.value.isNotEmpty 
        ? completeWhatsappNumber.value 
        : whatsappController.text.trim();
    final address = addressController.text.trim();

    void showMessage(String title, String message, Color backgroundColor) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('$title: $message'),
            backgroundColor: backgroundColor,
          ),
        );
    }

    if (name.isEmpty) {
      showMessage('Error', 'Full Name is required', Colors.red);
      return;
    }

    if (!isAddressSelected.value || selectedLat.value == 0.0) {
      showMessage(
        'Error',
        'Please select an address from suggestions',
        Colors.red,
      );
      return;
    }

    isUpdating.value = true;

    try {
      final Map<String, dynamic> bodyData = {
        "name": name,
        "address": address,
        "whatsappNumber": whatsappNumber,
        "coordinates[lat]": selectedLat.value,
        "coordinates[lng]": selectedLng.value,
      };

      if (selectedImage.value != null) {
        bodyData["image"] = await MultipartFile.fromFile(
          selectedImage.value!.path,
          filename: selectedImage.value!.path.split(Platform.pathSeparator).last,
        );
      }

      final formData = FormData.fromMap(bodyData);

      final response = await _networkCaller.patch(
        ApiUrls.userProfile,
        body: formData,
      );

      if (response.success) {
        showMessage(
          'Success',
          response.message ?? 'Profile updated successfully',
          Colors.green,
        );
      } else {
        showMessage('Error', response.message ?? 'Update failed', Colors.red);
      }
    } catch (e) {
      showMessage(
        'Error',
        'Something went wrong. Please try again.',
        Colors.red,
      );
    } finally {
      isUpdating.value = false;
    }
  }
}
