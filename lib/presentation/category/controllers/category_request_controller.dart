import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoryRequestController extends GetxController {
  final NetworkCaller _networkCaller = sl<NetworkCaller>();

  final nameController = TextEditingController();
  final descController = TextEditingController();

  final RxBool isLoading = false.obs;

  /// Image state
  final Rx<File?> categoryImage = Rx<File?>(null);

  /// Icon suggestion state
  final Rx<IconData?> selectedIcon = Rx<IconData?>(null);
  final RxString selectedIconName = ''.obs;
  final RxList<Map<String, dynamic>> suggestedIcons =
      <Map<String, dynamic>>[].obs;

  /// Keyword → icons mapping
  static const Map<String, List<Map<String, dynamic>>> _keywordIconMap = {
    'phone': [
      {'icon': Icons.phone, 'name': 'phone'},
      {'icon': Icons.smartphone, 'name': 'smartphone'},
      {'icon': Icons.mobile_friendly, 'name': 'mobile_friendly'},
      {'icon': Icons.phone_android, 'name': 'phone_android'},
      {'icon': Icons.phone_iphone, 'name': 'phone_iphone'},
    ],
    'mobile': [
      {'icon': Icons.smartphone, 'name': 'smartphone'},
      {'icon': Icons.phone_android, 'name': 'phone_android'},
      {'icon': Icons.mobile_screen_share, 'name': 'mobile_screen_share'},
    ],
    'car': [
      {'icon': Icons.directions_car, 'name': 'directions_car'},
      {'icon': Icons.car_repair, 'name': 'car_repair'},
      {'icon': Icons.time_to_leave, 'name': 'time_to_leave'},
      {'icon': Icons.directions_car_filled, 'name': 'directions_car_filled'},
      {'icon': Icons.electric_car, 'name': 'electric_car'},
    ],
    'vehicle': [
      {'icon': Icons.directions_car, 'name': 'directions_car'},
      {'icon': Icons.two_wheeler, 'name': 'two_wheeler'},
      {'icon': Icons.airport_shuttle, 'name': 'airport_shuttle'},
      {'icon': Icons.local_shipping, 'name': 'local_shipping'},
    ],
    'auto': [
      {'icon': Icons.directions_car, 'name': 'directions_car'},
      {'icon': Icons.car_repair, 'name': 'car_repair'},
      {'icon': Icons.build, 'name': 'build'},
    ],
    'engine': [
      {'icon': Icons.settings, 'name': 'settings'},
      {'icon': Icons.build, 'name': 'build'},
      {'icon': Icons.electric_bolt, 'name': 'electric_bolt'},
      {'icon': Icons.miscellaneous_services, 'name': 'miscellaneous_services'},
    ],
    'motor': [
      {'icon': Icons.settings, 'name': 'settings'},
      {'icon': Icons.electrical_services, 'name': 'electrical_services'},
      {'icon': Icons.electric_bolt, 'name': 'electric_bolt'},
    ],
    'tyre': [
      {'icon': Icons.radio_button_unchecked, 'name': 'radio_button_unchecked'},
      {'icon': Icons.circle, 'name': 'circle'},
      {'icon': Icons.loop, 'name': 'loop'},
      {'icon': Icons.rotate_right, 'name': 'rotate_right'},
    ],
    'tire': [
      {'icon': Icons.radio_button_unchecked, 'name': 'radio_button_unchecked'},
      {'icon': Icons.circle, 'name': 'circle'},
      {'icon': Icons.loop, 'name': 'loop'},
    ],
    'wheel': [
      {'icon': Icons.radio_button_unchecked, 'name': 'radio_button_unchecked'},
      {'icon': Icons.rotate_right, 'name': 'rotate_right'},
      {'icon': Icons.refresh, 'name': 'refresh'},
    ],
    'brake': [
      {'icon': Icons.warning, 'name': 'warning'},
      {'icon': Icons.pan_tool, 'name': 'pan_tool'},
      {'icon': Icons.front_hand, 'name': 'front_hand'},
      {'icon': Icons.stop, 'name': 'stop'},
    ],
    'battery': [
      {'icon': Icons.battery_5_bar, 'name': 'battery_5_bar'},
      {'icon': Icons.battery_charging_full, 'name': 'battery_charging_full'},
      {'icon': Icons.battery_full, 'name': 'battery_full'},
      {'icon': Icons.electric_bolt, 'name': 'electric_bolt'},
    ],
    'electric': [
      {'icon': Icons.electric_bolt, 'name': 'electric_bolt'},
      {'icon': Icons.electrical_services, 'name': 'electrical_services'},
      {'icon': Icons.bolt, 'name': 'bolt'},
      {'icon': Icons.power, 'name': 'power'},
    ],
    'electronics': [
      {'icon': Icons.devices, 'name': 'devices'},
      {'icon': Icons.electrical_services, 'name': 'electrical_services'},
      {'icon': Icons.memory, 'name': 'memory'},
      {'icon': Icons.developer_board, 'name': 'developer_board'},
    ],
    'light': [
      {'icon': Icons.light, 'name': 'light'},
      {'icon': Icons.wb_sunny, 'name': 'wb_sunny'},
      {'icon': Icons.light_mode, 'name': 'light_mode'},
      {'icon': Icons.flashlight_on, 'name': 'flashlight_on'},
      {'icon': Icons.highlight, 'name': 'highlight'},
    ],
    'lamp': [
      {'icon': Icons.wb_sunny, 'name': 'wb_sunny'},
      {'icon': Icons.light, 'name': 'light'},
      {'icon': Icons.highlight, 'name': 'highlight'},
    ],
    'tool': [
      {'icon': Icons.build, 'name': 'build'},
      {'icon': Icons.handyman, 'name': 'handyman'},
      {'icon': Icons.hardware, 'name': 'hardware'},
      {'icon': Icons.construction, 'name': 'construction'},
    ],
    'part': [
      {'icon': Icons.build, 'name': 'build'},
      {'icon': Icons.settings, 'name': 'settings'},
      {'icon': Icons.extension, 'name': 'extension'},
      {'icon': Icons.handyman, 'name': 'handyman'},
    ],
    'oil': [
      {'icon': Icons.opacity, 'name': 'opacity'},
      {'icon': Icons.water_drop, 'name': 'water_drop'},
      {'icon': Icons.local_gas_station, 'name': 'local_gas_station'},
    ],
    'fuel': [
      {'icon': Icons.local_gas_station, 'name': 'local_gas_station'},
      {'icon': Icons.ev_station, 'name': 'ev_station'},
      {'icon': Icons.water_drop, 'name': 'water_drop'},
    ],
    'seat': [
      {'icon': Icons.airline_seat_recline_extra, 'name': 'airline_seat_recline_extra'},
      {'icon': Icons.event_seat, 'name': 'event_seat'},
      {'icon': Icons.chair, 'name': 'chair'},
    ],
    'camera': [
      {'icon': Icons.camera, 'name': 'camera'},
      {'icon': Icons.camera_alt, 'name': 'camera_alt'},
      {'icon': Icons.videocam, 'name': 'videocam'},
    ],
    'audio': [
      {'icon': Icons.speaker, 'name': 'speaker'},
      {'icon': Icons.volume_up, 'name': 'volume_up'},
      {'icon': Icons.music_note, 'name': 'music_note'},
      {'icon': Icons.headphones, 'name': 'headphones'},
    ],
    'mirror': [
      {'icon': Icons.flip, 'name': 'flip'},
      {'icon': Icons.image, 'name': 'image'},
      {'icon': Icons.compare, 'name': 'compare'},
    ],
    'door': [
      {'icon': Icons.door_front_door, 'name': 'door_front_door'},
      {'icon': Icons.meeting_room, 'name': 'meeting_room'},
    ],
    'window': [
      {'icon': Icons.window, 'name': 'window'},
      {'icon': Icons.wb_sunny, 'name': 'wb_sunny'},
      {'icon': Icons.open_in_new, 'name': 'open_in_new'},
    ],
    'ac': [
      {'icon': Icons.ac_unit, 'name': 'ac_unit'},
      {'icon': Icons.thermostat, 'name': 'thermostat'},
      {'icon': Icons.air, 'name': 'air'},
    ],
    'filter': [
      {'icon': Icons.filter_alt, 'name': 'filter_alt'},
      {'icon': Icons.air, 'name': 'air'},
      {'icon': Icons.water, 'name': 'water'},
    ],
    'exhaust': [
      {'icon': Icons.air, 'name': 'air'},
      {'icon': Icons.cloud, 'name': 'cloud'},
      {'icon': Icons.smoke_free, 'name': 'smoke_free'},
    ],
    'suspension': [
      {'icon': Icons.compress, 'name': 'compress'},
      {'icon': Icons.unfold_less, 'name': 'unfold_less'},
      {'icon': Icons.height, 'name': 'height'},
    ],
    'clutch': [
      {'icon': Icons.swap_horiz, 'name': 'swap_horiz'},
      {'icon': Icons.compare_arrows, 'name': 'compare_arrows'},
      {'icon': Icons.sync_alt, 'name': 'sync_alt'},
    ],
    'gear': [
      {'icon': Icons.settings, 'name': 'settings'},
      {'icon': Icons.tune, 'name': 'tune'},
      {'icon': Icons.swap_vert, 'name': 'swap_vert'},
    ],
  };

  /// Default fallback icons shown when no keyword matches
  static final List<Map<String, dynamic>> _defaultIcons = [
    {'icon': Icons.category, 'name': 'category'},
    {'icon': Icons.label, 'name': 'label'},
    {'icon': Icons.folder, 'name': 'folder'},
    {'icon': Icons.inventory_2, 'name': 'inventory_2'},
    {'icon': Icons.widgets, 'name': 'widgets'},
    {'icon': Icons.extension, 'name': 'extension'},
  ];

  @override
  void onInit() {
    super.onInit();
    suggestedIcons.assignAll(_defaultIcons);
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    super.onClose();
  }

  // ── Image Picker ─────────────────────────────────────────────────

  Future<void> pickCategoryImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      categoryImage.value = File(picked.path);
    }
  }

  void removeCategoryImage() {
    categoryImage.value = null;
  }

  // ── Icon suggestion ───────────────────────────────────────────────

  void onNameChanged(String text) {
    final query = text.trim().toLowerCase();

    if (query.isEmpty) {
      suggestedIcons.assignAll(_defaultIcons);
      return;
    }

    final Set<String> seen = {};
    final List<Map<String, dynamic>> results = [];

    for (final entry in _keywordIconMap.entries) {
      if (entry.key.contains(query) || query.contains(entry.key)) {
        for (final icon in entry.value) {
          if (seen.add(icon['name'] as String)) {
            results.add(icon);
          }
        }
      }
    }

    suggestedIcons.assignAll(results.isEmpty ? _defaultIcons : results);
  }

  void selectIcon(IconData icon, String name) {
    selectedIcon.value = icon;
    selectedIconName.value = name;
  }

  // ── Submit ────────────────────────────────────────────────────────

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
      // Build the JSON data object per API spec
      final iconName = selectedIconName.value.isNotEmpty
          ? selectedIconName.value
          : 'category';

      final dataObject = <String, dynamic>{
        'name': name,
        'description': description,
        'icon': iconName,
      };

      final encodedData = jsonEncode(dataObject);

      // Debug log — visible in API logger output
      developer.log('[CategoryRequest] Sending data: $encodedData');

      final fields = <String, dynamic>{
        'data': encodedData,
      };

      // Attach image if selected (optional per API spec)
      final files = <MapEntry<String, File>>[];
      if (categoryImage.value != null) {
        files.add(MapEntry('image', categoryImage.value!));
      }

      final response = await _networkCaller.uploadMultipart(
        ApiUrls.categoryRequest,
        files: files,
        fields: fields,
      );

      if (response.success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category request submitted successfully'),
              backgroundColor: Colors.green,
            ),
          );
          // Reset form
          nameController.clear();
          descController.clear();
          categoryImage.value = null;
          selectedIcon.value = null;
          selectedIconName.value = '';
          suggestedIcons.assignAll(_defaultIcons);
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
