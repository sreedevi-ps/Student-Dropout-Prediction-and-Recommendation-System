import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retentionx/core/animation/app_animation_builder.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/features/view_recommendations/presentation/screens/screen_admin_recommendations.dart';
import 'package:retentionx/features/auth/presentation/screens/student_login_screen.dart';
import 'package:retentionx/features/auth/presentation/screens/screen_stundent_logout.dart';
import 'package:retentionx/features/data_entry/presentation/screens/screen_student_data_entry.dart';
import 'package:retentionx/features/home/presentation/menu_changer_bloc/menu_changer_bloc.dart';
import 'package:retentionx/features/profile/presentation/screens/admin_profile.dart';
import 'package:retentionx/features/profile/presentation/screens/screen_student_profile.dart';
import 'package:retentionx/features/student_list/presentation/screens/screen_students_list.dart';
import 'package:retentionx/features/view_recommendations/presentation/screens/view_recommendations.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<MenuChangerBloc>().add(MenuChangeRequested(
          index: 0,
          screen:
              widget.isAdmin ? adimnScreenscreens[0] : studentScreenscreens[0],
        ));
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuChangerBloc, MenuChangerState>(
      builder: (context, state) {
        return state is MenuChangerChangedSuccess
            ? Scaffold(
                extendBody: true,
                body: state.screen,
                bottomNavigationBar: DotCurvedBottomNav(
                  scrollController: _scrollController,
                  hideOnScroll: true,
                  indicatorColor: AppColors.themeColor,
                  backgroundColor: AppColors.navBarColor,
                  animationDuration: const Duration(milliseconds: 300),
                  animationCurve: Curves.ease,
                  selectedIndex: state.index,
                  indicatorSize: 5,
                  borderRadius: 25,
                  height: 70,
                  onTap: (index) {
                    context.read<MenuChangerBloc>().add(MenuChangeRequested(
                          index: index,
                          screen: widget.isAdmin
                              ? adimnScreenscreens[index]
                              : studentScreenscreens[index],
                        ));
                    // setState(() => _currentPage = index);
                  },
                  items: [
                    Icon(
                      Icons.home,
                      color: state.index == 0
                          ? AppColors.themeColor
                          : AppColors.unselectedIconColor,
                    ),
                    Icon(
                      widget.isAdmin ? Icons.person_add : Icons.book,
                      color: state.index == 1
                          ? AppColors.themeColor
                          : AppColors.unselectedIconColor,
                    ),
                    if (!widget.isAdmin)
                      Icon(
                        Icons.cast_for_education,
                        color: state.index == 2
                            ? AppColors.themeColor
                            : AppColors.unselectedIconColor,
                      ),
                    Icon(
                      Icons.person,
                      color: state.index == 3
                          ? AppColors.themeColor
                          : AppColors.unselectedIconColor,
                    ),
                  ],
                ),
              )
            : SizedBox.shrink();
      },
    );
  }

  List<Widget> adimnScreenscreens = [
    ScreenStudentsList(),
    ScreenStudentDataEntry(),
    // Center(child: Text("Cousrses")),
    ScreenAdminProfile()
    // ScreenStudentProfile()
  ];

  List<Widget> studentScreenscreens = [
    AppAnimationBuilder(
      child: ScreenStudentProfile(
        isAdmin: false,
      ),
    ),
    ScreenAdminRecommendations(),
    ScreenViewRecommendations(),
    // ScreenViewRecommendations(),
    // ScrenAdminDataEntry(),
    //
    ScreenStudentLogout()
  ];
}
