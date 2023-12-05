import 'package:flutter/material.dart';

class CategoryTileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // Adjust the width based on your design
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100, // Adjust the height based on your design
            color: Colors.grey[300],
          ),
          SizedBox(height: 8),
          Container(
            height: 12,
            width: 80,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
