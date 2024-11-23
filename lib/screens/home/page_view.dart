import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rider/screens/chat/chat_screen.dart';
import 'package:rider/screens/home/home_screen.dart';
import 'package:rider/screens/home/search_screen.dart';
import 'package:rider/screens/profile/profile_screen.dart';
import 'package:rider/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_pageController.page?.round() != 0) {
            _pageController.previousPage(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
            return false;
          }
          return true;
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: const [
            HomeScreen(),
            // SearchScreen(),
            ChatScreen(),
            AccountScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.secondary,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(MingCute.home_1_line),
            label: "Home",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(MingCute.search_3_line),
          //   label: "Search",
          // ),
          BottomNavigationBarItem(
            icon: Icon(MingCute.chat_1_line),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(MingCute.user_4_line),
            label: "Account",
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
