import 'package:flutter/material.dart';
import 'package:notice_board/utils/const.dart';

class TutorTile extends StatelessWidget {
  const TutorTile(
      {super.key,
      required this.tutorName,
      required this.subjectSkill,
      required this.location,
      required this.availability,
      required this.contact,
      required this.duration});
  final String tutorName;
  final String subjectSkill;
  final String location;
  final String availability;
  final String contact;
  final String duration;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        // height: height * 0.20,
        width: double.infinity,
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
        child: ListTile(
          title: Text(
            "$tutorName",
            textAlign: TextAlign.center,
          ),
          subtitle: Column(
            children: [
              Text("Subject: $subjectSkill"),
              Text("From: $availability for $duration hour"),
              Text("Location: $location"),
              Text("Contact: $contact"),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.call_rounded),
              Icon(Icons.message_outlined),
            ],
          ),
        ));
  }
}
