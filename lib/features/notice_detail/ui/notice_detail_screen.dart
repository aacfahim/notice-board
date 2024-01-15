import 'package:flutter/material.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/home/model/notice_tile_model.dart';
import 'package:notice_board/utils/const.dart';

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key, required this.data});
  final NoticeDataModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(text: data.attributes!.innerTitle.toString()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            title: SelectableText(
              data.attributes!.innerTitle.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: SelectableText(data.attributes!.title.toString()),
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
