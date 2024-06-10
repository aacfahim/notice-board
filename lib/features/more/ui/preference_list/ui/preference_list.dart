import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:notice_board/features/category/bloc/category_bloc.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/home/model/preference_notifier.dart';
import 'package:notice_board/features/home/repos/preferred_degree_dropdown.dart';
import 'package:notice_board/features/home/ui/widgets/preference_widget.dart';
import 'package:notice_board/features/home/ui/widgets/show_dialogue_criteria.dart';
import 'package:notice_board/features/more/ui/preference_list/model/preference_model.dart';
import 'package:notice_board/features/more/ui/preference_list/model/preference_notifier.dart';
import 'package:notice_board/features/more/ui/preference_list/repo/user_preference_services.dart';
import 'package:notice_board/utils/const.dart';
import 'package:provider/provider.dart';

class PreferenceList extends StatefulWidget {
  PreferenceList({super.key, this.isBack = false});
  final bool isBack;

  @override
  State<PreferenceList> createState() => _PreferenceListState();
}

class _PreferenceListState extends State<PreferenceList> {
  List<UserPreferenceDataModel> prefList = [];

  @override
  void initState() {
    super.initState();
    fetchPrefs();
  }

  Future fetchPrefs() async {
    prefList = await UserPreferenceServices.fetchUserPreferenceList();
    setState(() {});
  }

  Future<void> _refreshData() async {
    fetchPrefs();
  }

  // Function to parse and format the DateTime string
  String formatDateTime(String dateTimeString) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime != null) {
      return DateFormat('d MMMM yyyy, hh:mm a').format(dateTime.toLocal());
    } else {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final preferenceNotifier = Provider.of<PreferenceNotifier>(context);
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.info,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue.shade200,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            label: 'Add new preference',
            onTap: () {
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
                            if (preferenceModel.degreeId == 3) {
                              // Specific check for M.Phil degree
                              if (preferenceModel.subjectId == null ||
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
                                    'Selected Subject: ${preferenceModel.subjectId}');
                                print(
                                    'Selected Year: ${preferenceModel.selectedYear}');
                                print(
                                    'Selected Category: ${preferenceModel.selectedCategory}');

                                PreferredDegree.setPreference(preferenceModel)
                                    .then((value) =>
                                        preferenceModel.clearState());

                                preferenceNotifier.setPreferenceSaved(true);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Preference Saved'),
                                  ),
                                );

                                Navigator.pop(context);
                              }
                            } else if (preferenceModel.subjectId == null ||
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
                              print(
                                  'Selected Category: ${preferenceModel.selectedCategory}');

                              PreferredDegree.setPreference(preferenceModel)
                                  .then(
                                      (value) => preferenceModel.clearState());

                              preferenceNotifier.setPreferenceSaved(true);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Preference Saved'),
                                ),
                              );

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
                              print(
                                  'Selected Category: ${preferenceModel.selectedCategory}');

                              PreferredDegree.setPreference(preferenceModel)
                                  .then(
                                      (value) => preferenceModel.clearState());

                              preferenceNotifier.setPreferenceSaved(true);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Preference Saved'),
                                ),
                              );

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
          ),
          SpeedDialChild(
            child: Icon(Icons.remove),
            backgroundColor: Colors.red,
            label: 'Reset preference',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Reset'),
                    content:
                        Text('Are you sure you want to reset the preference?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Dismiss the dialog
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          preferenceNotifier.removePreference();
                          Navigator.of(context).pop(); // Dismiss the dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Preference reset completed'),
                            ),
                          );
                        },
                        child: Text('Confirm'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      appBar: CommonAppBar(text: "Preference List", isBack: widget.isBack),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: ListView.builder(
            itemCount: prefList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  int prefId = int.parse(prefList[index].id!);

                  await UserPreferenceServices.removeUserPreferenceById(prefId);

                  setState(() {
                    prefList.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Item dismissed'),
                    ),
                  );
                },
                background: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Card(
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0), // Add bottom padding here
                  child: Card(
                    child: ListTile(
                      title: Text("${index + 1}. " +
                          formatDateTime(prefList[index]
                              .attributes!
                              .createdAt
                              .toString())),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
