import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/widgets/common_appbar.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(text: "Bookmark"),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bookmark",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                  itemCount: 30,
                  separatorBuilder: (index, _) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return NoticeTile(
                        noticeType: "Exam Notice",
                        title:
                            "অর্নাস ৩য় ও ৪র্থ বর্ষের পরিক্ষার ফলাফল ঘোষনা করা হবে আগামী ৩ তারিখে",
                        date: "25 Sept 2023");
                  }),
            )
          ],
        ),
      ),
    );
  }
}
