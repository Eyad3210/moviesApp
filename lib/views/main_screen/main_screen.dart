import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/views/movies_screen/movies_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../book_marks/book_marks_screen.dart';
import '../search_screen/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;
  List<Widget> pages = [
    const MoviesScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text("Movie App"),
        actions: [IconButton(onPressed: (){Get.to(    const BookMarkScreen()
);}, icon: const Icon(Icons.bookmark))],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              offset: const Offset(0, -3),
              blurRadius: 12,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: SalomonBottomBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              unselectedColor: Colors.black,
              icon: Icon(
                Icons.home,
                color:
                    _currentIndex == 0 ? Colors.white : const Color(0xffa4a4a4),
              ),
              title: const Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.red[900],
            ),
      
            SalomonBottomBarItem(
              icon: Icon(
                Icons.search,
                color:
                    _currentIndex == 1 ? Colors.white : const Color(0xffa4a4a4),
              ),
              title: const Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.red[900],
            ),
      
       /*      SalomonBottomBarItem(
              icon: Icon(
                Icons.star_border,
                color:
                    _currentIndex == 2 ? Colors.white : const Color(0xffa4a4a4),
              ),
              title: const Text(
                "Bookmark",
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.red[900],
            ), */
          ],
        ),
      )),
      body: pages[_currentIndex],
    );
  }
}
