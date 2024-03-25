import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/home/model/notice_tile_model.dart';
import 'package:notice_board/utils/const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart'; // Import for storage permission

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key, required this.data});
  final NoticeDataModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 196, 195, 195),
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.5,
                        spreadRadius: 0.0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0)),
                child: Image.asset("assets/back_button.png"),
              ),
            ),
          ),
        ),
        title: Text(
          data.attributes!.innerTitle.toString(),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              print(data.attributes!.nuNoticePdfLink.toString());
              Share.share("Click the following link to see the notice:\n" +
                  data.attributes!.nuNoticePdfLink.toString() +
                  "\n\n- National University Notice Board");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.share,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.download),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: PDF(
              swipeHorizontal: true,
            ).fromUrl(data.attributes!.nuNoticePdfLink.toString()),
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
