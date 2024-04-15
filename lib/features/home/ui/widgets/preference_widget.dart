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
                  title: Text('Provide Information for Personalized Notice',
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
                            listen: false,
                          );

                          // Check if degree is selected and if it's not equal to 2 (assuming 2 is the ID for degree 2)
                          if (preferenceModel.degreeId != 2) {
                            // For degrees other than 2, check if subject, faculty, year, and semester are selected
                            if (preferenceModel.subjectId == null ||
                                preferenceModel.selectedYear == null ||
                                preferenceModel.selectedSemester == null) {
                              // If any of the fields are null, show a message to the user
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Fields are required'),
                                    content: Text(
                                        'Please fill out all preference fields.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // If all fields are filled, proceed to set the preference
                              print(
                                  'Selected Degree: ${preferenceModel.degreeId}');
                              print(
                                  'Selected Subject: ${preferenceModel.subjectId}');
                              print(
                                  'Selected Year: ${preferenceModel.selectedYear}');
                              print(
                                  'Selected Semester: ${preferenceModel.selectedSemester}');

                              PreferredDegree.setPreference(preferenceModel)
                                  .then(
                                      (value) => preferenceModel.clearState());

                              Navigator.pop(context);
                            }
                          } else {
                            // For degree 2, check if faculty and year are selected
                            if (preferenceModel.facultyId == null ||
                                preferenceModel.selectedYear == null) {
                              // If any of the fields are null, show a message to the user
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Fields are required'),
                                    content: Text(
                                        'Please fill out all preference fields.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // If all fields are filled, proceed to set the preference
                              print(
                                  'Selected Degree: ${preferenceModel.degreeId}');
                              print(
                                  'Selected Faculty: ${preferenceModel.facultyId}');
                              print(
                                  'Selected Year: ${preferenceModel.selectedYear}');

                              PreferredDegree.setPreference(preferenceModel)
                                  .then(
                                      (value) => preferenceModel.clearState());

                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text('Set Preference',
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
