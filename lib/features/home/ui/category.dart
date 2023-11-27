import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/custom_navbar.dart';
import 'package:notice_board/features/home/ui/widgets/common_appbar.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6F7),
      appBar: CommonAppBar(text: "Category"),
    );
  }
}
