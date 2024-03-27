import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:notice_board/features/home/model/notice_tile_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class NoticeDetailScreen extends StatefulWidget {
  const NoticeDetailScreen({super.key, required this.data});
  final NoticeDataModel data;

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  String _progress = '';
  bool _downloading = false;

  String generateFileName() {
    final now = DateTime.now();
    final formattedDate =
        '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().substring(2)}';
    return 'NU-Notice-$formattedDate';
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> downloadFile(String url) async {
    setState(() {
      _downloading = true;
      _progress = 'Downloading...';
    });

    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    final directory = await getDownloadPath();
    if (directory == null) {
      setState(() {
        _progress = 'Error: Download path not available';
        _downloading = false;
      });
      return;
    }

    final filePath = '$directory/${generateFileName()}.pdf';

    final file = File(filePath);
    await file.writeAsBytes(bytes);

    setState(() {
      _downloading = false;
      _progress = 'Downloaded to: $filePath';
    });

    print(response.statusCode);

    var downloadOK = SnackBar(content: Text('Download Completed'));
    var downloadFailed =
        SnackBar(content: Text('Something went wrong, try again'));

    if (!_downloading && response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(downloadOK);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(downloadFailed);
    }
  }

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
          widget.data.attributes!.innerTitle.toString(),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              print(widget.data.attributes!.nuNoticePdfLink.toString());
              Share.share("Click the following link to see the notice:\n" +
                  widget.data.attributes!.nuNoticePdfLink.toString() +
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
              downloadFile(widget.data.attributes!.nuNoticePdfLink.toString());
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
            ).fromUrl(widget.data.attributes!.nuNoticePdfLink.toString()),
          ),
        ],
      ),
    );
  }
}
