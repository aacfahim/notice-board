import 'package:flutter/material.dart';

class ShowDialogueCriteria extends StatefulWidget {
  const ShowDialogueCriteria({super.key});

  @override
  State<ShowDialogueCriteria> createState() => _ShowDialogueCriteriaState();
}

class _ShowDialogueCriteriaState extends State<ShowDialogueCriteria> {
  String CollegeDropdownValue = 'কলেজের নাম';
  String DeptDropdownValue = 'ডিপার্টমেন্ট';
  String DegreeDropdownValue = 'ডিগ্রী';
  String SemesterDropdownValue = 'সেমিস্টার/ইয়ার';
  var colleges = [
    'কলেজের নাম',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var depts = [
    'ডিপার্টমেন্ট',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var degrees = [
    'ডিগ্রী',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var semesters = [
    'সেমিস্টার/ইয়ার',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton(
              value: CollegeDropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: colleges.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  CollegeDropdownValue = newValue!;
                });
              },
            ),
          ),
          DropdownButton(
            value: DeptDropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: depts.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                DeptDropdownValue = newValue!;
              });
            },
          ),
          DropdownButton(
            value: DegreeDropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: degrees.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                DegreeDropdownValue = newValue!;
              });
            },
          ),
          DropdownButton(
            value: SemesterDropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: semesters.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                SemesterDropdownValue = newValue!;
              });
            },
          )
        ],
      ),
    );
  }
}
