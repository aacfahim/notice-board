import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CriteriaWidget extends StatelessWidget {
  const CriteriaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: Text("National University",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: const Text(
                "Check this app regularly to get any kinds exam notices 2023-24",
                style: TextStyle(color: Colors.white)),
            trailing: CircleAvatar(
              child: SvgPicture.asset(
                "assets/board_bell_icon.svg",
                fit: BoxFit.cover,
              ),
            )),
        ElevatedButton(
            onPressed: () {},
            child: Text(
              "Add your criteria",
              style: TextStyle(fontSize: 12),
            ))
      ],
    );
  }
}
