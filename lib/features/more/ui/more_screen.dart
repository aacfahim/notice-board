import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/widgets/common_appbar.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ListTile(
          leading: Icon(Icons.info),
          title: Text("About App"),
        ),
        divider(),
        ListTile(
          leading: Icon(Icons.privacy_tip),
          title: Text("Privacy Policy"),
        ),
        divider(),
        ListTile(
          leading: Icon(Icons.feedback),
          title: Text("Feedback"),
        ),
        divider(),
        ListTile(
          leading: Icon(Icons.share),
          title: Text("Share the app"),
        ),
        divider(),
      ]),
      appBar: CommonAppBar(text: "More links"),
    );
  }
}

class divider extends StatelessWidget {
  const divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      thickness: .2,
      indent: 10,
      endIndent: 10,
    );
  }
}
