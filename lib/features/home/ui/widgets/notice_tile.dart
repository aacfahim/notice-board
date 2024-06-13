import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoticeTile extends StatelessWidget {
  const NoticeTile(
      {super.key,
      this.bookmarked = false,
      required this.title,
      this.noticeType,
      required this.date,
      this.isNoticeTypeShown = true});
  final bool bookmarked;
  final String title;
  final noticeType;
  final String date;
  final bool isNoticeTypeShown;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.all(12),
        height: height * .2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1, //5
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.80,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
                // bookmarked
                //     ? Image.asset("assets/bookmarked.png")
                //     : Image.asset("assets/unbookmarked.png")
              ],
            ),
            Row(
              mainAxisAlignment: !isNoticeTypeShown
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xffE9F0FF),
                  child: isNoticeTypeShown == false
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: Text(noticeType),
                        ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/calendar-dates.svg",
                    ),
                    SizedBox(width: 5),
                    Text(date)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
