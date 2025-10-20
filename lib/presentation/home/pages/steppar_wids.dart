import 'package:flutter/material.dart';

class CustomHorizontalStepper extends StatefulWidget {
  const CustomHorizontalStepper({super.key});

  @override
  State<CustomHorizontalStepper> createState() =>
      _CustomHorizontalStepperState();
}

class _CustomHorizontalStepperState extends State<CustomHorizontalStepper> {
  int currentStep = 1; // 🔹 1-based index (1, 2, 3)

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // progress line width calculation (based on current step)
    double progressWidth = ((currentStep - 1) / (3 - 1)) * (screenWidth - 0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Custom Horizontal Stepper")),
      body: Column(
        children: [
          // 🔹 Stepper UI Section
          SizedBox(
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Grey base line
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Container(height: 3, color: Colors.grey[300]),
                ),

                // Blue progress line
                Positioned(
                  top: 10,
                  left: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 3,
                    width: progressWidth,
                    color: Colors.blue,
                  ),
                ),

                // Step Circles + Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    int step = index + 1;
                    bool isActive = step <= currentStep;

                    return Column(
                      children: [
                        // Circle (20x20)
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.blue
                                : Colors.grey.shade300,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isActive
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "$step",
                              style: TextStyle(
                                fontSize: 10,
                                color: isActive ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Step $step",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isActive
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isActive ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 🔹 Step Content Section
          Text(
            "You are on Step $currentStep",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 20),

          // 🔹 Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: currentStep > 1
                    ? () => setState(() => currentStep--)
                    : null,
                child: const Text("Back"),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: currentStep < 3
                    ? () => setState(() => currentStep++)
                    : null,
                child: const Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
