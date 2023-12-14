import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/widgets/categories_tile.dart';
import 'package:shimmer/shimmer.dart';

class CategoryGridShimmer extends StatelessWidget {
  const CategoryGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 16.0,
      ),
      padding: EdgeInsets.all(6.0),
      itemCount: 30,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[100]!,
          child: CategoryTile(title: "", noticesCount: 0),
        );
      },
    );
  }
}
