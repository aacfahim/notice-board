import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notice_board/features/home/model/preference_notifier.dart';
import 'package:notice_board/features/home/repos/preferred_degree_dropdown.dart';
import 'package:notice_board/features/home/ui/widgets/show_dialogue_criteria.dart';
import 'package:notice_board/utils/const.dart';
import 'package:provider/provider.dart';

class PreferenceWidget extends StatelessWidget {
  const PreferenceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final preferenceModel = Provider.of<PreferenceModel>(context);
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
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text('প্রয়োজনীয় নোটিশ পেতে তথ্য দিয়ে সহায়তা করুন',
                      style: TextStyle(fontSize: 15)),
                  icon: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, color: Color(0xffE80A0A)))),
                  content: ShowDialoguePreferrence(),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                        ),
                        onPressed: () {
                          final preferenceModel = Provider.of<PreferenceModel>(
                              context,
                              listen: false);
                          print('Selected Degree: ${preferenceModel.degreeId}');
                          print(
                              'Selected Subject: ${preferenceModel.subjectId}');
                          print(
                              'Selected Faculty: ${preferenceModel.facultyId}');
                          print(
                              'Selected Year: ${preferenceModel.selectedYear}');
                          print(
                              'Selected Semester: ${preferenceModel.selectedSemester}');

                          PreferredDegree.setPreference(preferenceModel);

                          preferenceModel.clearState();
                        },
                        child: Text('সেট করুন',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              "Add your preference",
              style: TextStyle(fontSize: 12),
            ))
      ],
    );
  }
}
