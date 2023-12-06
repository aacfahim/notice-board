import 'package:flutter/material.dart';

class CategoryTileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .37,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * .37,
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
