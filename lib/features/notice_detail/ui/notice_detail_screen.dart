import 'package:flutter/material.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/utils/const.dart';

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(text: title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            title: SelectableText(
              "ব্যবহারিক পরীক্ষার ফলাফল এবং মৌখিক পরীক্ষার সময়সূচী সংক্রান্ত",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: SelectableText(
                "মৌখিক পরীক্ষার তারিখঃ ৫ অক্টোবর ২০২৩ বাংলাদেশ সুপ্রীম কোর্ট, হাইকোর্ট বিভাগে স্টেনোগ্রাফার এর চুড়ান্ত ব্যবহারিক পরীক্ষার ফলাফল এবং মৌখিক পরীক্ষার সময়সূচী সংক্রান্ত (স্মারক নং ৮৩৭৯) পরীক্ষার প্রস্তুতিমূলক বিভিন্ন PDF এবং অন্যান্য বিষয়ে আপডেট থাকতে আমাদের এই এ্যাপ্স আপনার তথ্য দিয়ে সাহায্য করুন। প্রতিনিয়ত চেক করুন। অথবা ফেসবুক পেজে লাইক দিন- fb.com/BDCareerGuide ওয়েবসাইট: www.prebd.com "),
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              label: Text(
                "Share the resource",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
