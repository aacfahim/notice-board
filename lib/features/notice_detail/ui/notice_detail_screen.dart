import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/home/model/notice_tile_model.dart';
import 'package:notice_board/utils/const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart'; // Import for storage permission

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
          InkWell(
            onTap: () async {
              // Request storage permission with informative message
              final status = await Permission.storage.request();
              if (status.isGranted) {
                _downloadPDF(
                    data.attributes!.nuNoticePdfLink.toString(), context);
              } else if (status.isPermanentlyDenied) {
                // Handle permanently denied scenario (e.g., open app settings)
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Storage Permission Required'),
                    content: Text(
                      'The app needs storage permission to download PDFs. '
                      'Please open app settings and grant permission.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => openAppSettings(), // Open app settings
                        child: Text('Open Settings'),
                      ),
                    ],
                  ),
                );
              } else {
                // Handle other permission denial cases (e.g., show a snackbar)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Storage permission denied. Download failed.'),
                  ),
                );
              }
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(data.attributes!.nuNoticePdfLink.toString()),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            label: Text(
              "Share",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadPDF(String pdfUrl, BuildContext context) async {
    final response = await http.get(Uri.parse(pdfUrl));

    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = Uri.parse(pdfUrl).pathSegments.last; // Extract filename
      final file = File('${directory.path}/$fileName');

      await file.writeAsBytes(response.bodyBytes);

      print(directory.path); // For debugging

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF downloaded successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to download PDF. Status code: ${response.statusCode}'),
        ),
      );
    }
  }
}
