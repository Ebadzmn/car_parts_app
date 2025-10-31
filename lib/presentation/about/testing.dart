import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Consider tablet when width is 600dp or more
        bool isTablet = constraints.maxWidth >= 600;
        
        return Container(
          height: isTablet ? 280 : 200,
          color: Colors.blue,
          child: Center(
            child: Text(
              isTablet ? 'Tablet Mode (280)' : 'Mobile Mode (200)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}