import 'package:flutter/material.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/more/ui/preference_list.dart';

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
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PreferenceList(isBack: true)));
          },
          child: ListTile(
            leading: Icon(Icons.collections_bookmark),
            title: Text("Preference"),
          ),
        ),
        divider(),
        ListTile(
          leading: Icon(Icons.share),
          title: Text("Share the app"),
        ),
        divider(),
      ]),
      appBar: CommonAppBar(text: "More links", isBack: false),
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
