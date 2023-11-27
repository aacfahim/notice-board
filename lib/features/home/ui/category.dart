import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/custom_navbar.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category")),
    );
  }
}
