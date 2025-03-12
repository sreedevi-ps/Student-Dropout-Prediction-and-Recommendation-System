import 'package:flutter/material.dart';
import 'package:retentionx/core/app_routing/app_routing.dart';
import 'package:retentionx/core/local_db/localdb.dart';
import 'package:retentionx/features/auth/presentation/screens/selection_screen.dart';
import 'package:retentionx/features/home/presentation/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    Map<String, dynamic>? userData;
    userData = await LocalDatabase().getData("user");
    if (userData == null) {
      AppRouting.goRemoveAll(screen: SelectionScreen(), context: context);
    } else {
      AppRouting.goRemoveAll(
          screen: Home(isAdmin: userData["isadmin"]), context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/RX logo.png',
          height: 200,
        ),
      ),
    );
  }
}
