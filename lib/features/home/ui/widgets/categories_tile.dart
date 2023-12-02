import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notice_board/utils/const.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {super.key, required this.title, required this.noticesCount});
  final String title;
  final int noticesCount;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .33,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                "assets/category_icon.svg",
                fit: BoxFit.cover,
              ),
              SizedBox(height: 6),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$noticesCount notices"),
                  Icon(Icons.arrow_forward, color: PRIMARY_COLOR),
                ],
              ),
            ]),
      ),
    );
  }
}
