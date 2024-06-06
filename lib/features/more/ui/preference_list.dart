import 'package:flutter/material.dart';
import 'package:notice_board/features/category/bloc/category_bloc.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';

class PreferenceList extends StatefulWidget {
  PreferenceList({super.key, this.isBack = false});
  final bool isBack;

  @override
  State<PreferenceList> createState() => _PreferenceListState();
}

class _PreferenceListState extends State<PreferenceList> {
  List<DateTime> items = [];

  @override
  void initState() {
    super.initState();
    // Initialize the list with some DateTime objects
    items = [
      DateTime(2023, 1, 1),
      DateTime(2023, 2, 1),
      DateTime(2023, 3, 1),
      DateTime(2023, 4, 1),
      DateTime(2023, 5, 1),
      DateTime(2023, 6, 1),
    ];
  }

  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(text: "Preference List", isBack: widget.isBack),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(items[index].toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    items.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Item dismissed'),
                    ),
                  );
                },
                background: Card(
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
                child: Card(
                  child: ListTile(
                    title: Text(items[index].toString()),
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
