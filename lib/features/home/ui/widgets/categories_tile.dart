import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notice_board/utils/const.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile(
      {super.key,
      required this.title,
      required this.categorieLogoLink,
      this.noticesCount});
  final String title;
  int? noticesCount;
  final String categorieLogoLink;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .37,
      // height: 10,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // SvgPicture.asset(
          //   "assets/category_icon.svg",
          //   fit: BoxFit.cover,
          //   width: 65,
          // ),

          Image.network(
            categorieLogoLink,
            fit: BoxFit.fill,
            height: height * .099,
          ),

          // SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Icon(Icons.arrow_forward, color: PRIMARY_COLOR),
            ],
          ),
          // SizedBox(height: 3),
          // Row(
          //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     // Text("$noticesCount notices"),
          //     Icon(Icons.arrow_forward, color: PRIMARY_COLOR),
          //   ],
          // ),
        ]),
      ),
    );
  }
}
