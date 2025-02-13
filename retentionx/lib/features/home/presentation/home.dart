import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/features/auth/presentation/screens/login_screen.dart';
import 'package:retentionx/features/data_entry/presentation/screens/screen_student_data_entry.dart';
import 'package:retentionx/features/profile/presentation/screens/admin_profile.dart';
import 'package:retentionx/features/profile/presentation/screens/screen_student_profile.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      
      body: widget.isAdmin
          ? adimnScreenscreens[_currentPage]
          : studentScreenscreens[_currentPage],






      bottomNavigationBar: DotCurvedBottomNav(
        scrollController: _scrollController,
        hideOnScroll: true,
        indicatorColor: AppColors.themeColor,
        backgroundColor: AppColors.navBarColor,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.ease,
        selectedIndex: _currentPage,
        indicatorSize: 5,
        borderRadius: 25,
        height: 70,
        onTap: (index) {
          setState(() => _currentPage = index);
        },
        items: [
          Icon(
            Icons.home,
            color: _currentPage == 0
                ? AppColors.themeColor
                : AppColors.unselectedIconColor,
          ),
          Icon(
            widget.isAdmin ? Icons.person_add : Icons.book,
            color: _currentPage == 1
                ? AppColors.themeColor
                : AppColors.unselectedIconColor,
          ),
          Icon(
            Icons.cast_for_education,
            color: _currentPage == 2
                ? AppColors.themeColor
                : AppColors.unselectedIconColor,
          ),
          Icon(
            Icons.person,
            color: _currentPage == 3
                ? AppColors.themeColor
                : AppColors.unselectedIconColor,
          ),
        ],
      ),
    );
  }

  List<Widget> adimnScreenscreens = [
    Center(child: Text("Home")),
    ScreenStudentDataEntry(),
    Center(child: Text("Cousrses")),
    ScreenAdminProfile()
    // ScreenStudentProfile()
  ];

  List<Widget> studentScreenscreens = [
    Center(child: Text("Stdeunt Home")),
    Center(child: Text("Student page")),
    // ScrenAdminDataEntry(),
    Center(child: Text("student Cousrses")),
    ScreenStudentProfile()
  ];
}
