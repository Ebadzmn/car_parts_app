import 'package:flutter/material.dart';

class RatingStars extends StatefulWidget {
  final int maxRating;
  final double iconSize;
  final Function(int) onRatingChanged;

  const RatingStars({
    super.key,
    this.maxRating = 5,
    this.iconSize = 30.0,
    required this.onRatingChanged,
  });

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  int currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              currentRating = index + 1;
            });
            widget.onRatingChanged(currentRating);
          },
          icon: Icon(
            index < currentRating ? Icons.star_outline : Icons.star_outline,
            color: index < currentRating ? Colors.amber : Colors.grey,
            size: widget.iconSize,
            fontWeight: FontWeight.bold,
          ),
        );
      }),
    );
  }
}
