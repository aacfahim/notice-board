import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/custom_navbar.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar())),
          child: Card(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                  //   boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey,
                  //     offset: Offset(0.0, 1.0), //(x,y)
                  //     // blurRadius: 1.0,
                  //   ),
                  // ],
                  color: Color(0xffF5F6F7),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Image.asset("assets/back_button.png"),
            ),
          ),
        ),
      ),
      title: Text(
        text,
      ),
      centerTitle: true,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
