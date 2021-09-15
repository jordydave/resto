import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rate;

  RatingStars(this.rate);

  @override
  Widget build(BuildContext context) {
    int numberOfStars = rate.round();

    return Row(
      children: List<Widget>.generate(
            5,
            (index) => Icon(
              (index < numberOfStars) ? Icons.star : Icons.star_border_outlined,
              size: 16,
              color: Colors.yellow,
            ),
          ) +
          [
            SizedBox(width: 4),
            Text(
              rate.toString(),
            ),
          ],
    );
  }
}
