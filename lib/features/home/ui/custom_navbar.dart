import 'package:flutter/material.dart';
import 'package:notice_board/features/home/ui/category.dart';
import 'package:notice_board/features/home/ui/home.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Home(),
          Category(),
          Home(),
          Category(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(30))),
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            // _pageController.animateToPage(
            //   index,
            //   duration: Duration(milliseconds: 500),
            //   curve: Curves.easeInOut,
            // );
            _pageController.jumpToPage(
              index,
              // duration: Duration(milliseconds: 500),
              // curve: Curves.easeInOut,
            );
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text("Home"),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.grid_view),
              title: Text("Category"),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.bookmark_outline),
              title: Text("Bookmark"),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.menu_rounded),
              title: Text("More"),
            ),
          ],
        ),
      ),
    );
  }
}
