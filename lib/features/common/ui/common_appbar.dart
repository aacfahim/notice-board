import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/custom_navbar.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // shadowColor: Colors.grey,
      // elevation: 2,
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar())),
          child: Card(
            // elevation: 3,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 196, 195, 195),
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.5,
                  spreadRadius: 0.0,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
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
