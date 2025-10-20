import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';

class StepForms extends StatelessWidget {
  final int step;
  final Function(Map<String, dynamic>) onChanged;

  const StepForms({super.key, required this.step, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    switch (step) {
      case 1:
        return StepOneForm(onChanged: onChanged);
      case 2:
        return StepTwoForm(onChanged: onChanged);
      case 3:
        return StepThreeForm(onChanged: onChanged);
      default:
        return const SizedBox.shrink();
    }
  }
}

class StepOneForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onChanged;
  const StepOneForm({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(label: 'Full Name', hintText: 'Enter your full name'),
        CustomTextField(label: 'Full Name', hintText: 'Enter your full name'),
      ],
    );
  }
}

class StepTwoForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onChanged;
  const StepTwoForm({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextField(
        //   decoration: const InputDecoration(labelText: 'Address'),
        //   onChanged: (value) => onChanged({'address': value}),
        // ),
        CustomTextField(label: 'Full Name', hintText: 'Enter your full name'),
        CustomTextField(label: 'Full Name', hintText: 'Enter your full name'),
      ],
    );
  }
}

class StepThreeForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onChanged;
  const StepThreeForm({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Review Information',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        const Text("✅ All information looks good."),
      ],
    );
  }
}
